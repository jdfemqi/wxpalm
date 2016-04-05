//
//  HealthTourismViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/31.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HealthTourismViewController.h"
#import "TourismTableViewCell.h"
#import "KxMenu.h"

#define classification_all              0
#define classification_winter           1   // 冬季温养 固精养气
#define classification_OldLine          2   // 适合老年专线
#define classification_HealthCare       3   // 养生养老 基地游
#define classification_springBlossoms   4   //春暖花开 万物复苏
#define classification_Autumn           5   // 秋高气爽 结伴而行

@interface HealthTourismViewController ()
{
    NSMutableDictionary* _dicHealthTourism;
    
    NSMutableDictionary* _dicClassification;    // 类型

    
    NSMutableArray* _arrayHealthTourism;
    NSMutableArray* _arrayShowItems;
}
@property (weak, nonatomic) IBOutlet UITableView *_tableView;      // 特色图片
@property (weak, nonatomic) IBOutlet UIButton *_btnType;      // 分类按钮
@end

@implementation HealthTourismViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayHealthTourism = [[NSMutableArray alloc]init];
    _arrayShowItems = [[NSMutableArray alloc]init];
    _dicClassification = [[NSMutableDictionary alloc]init];
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"HealthTourismInfo" ofType:@"plist"];   // 商品类型
    _dicHealthTourism = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    // 旅游类型
    NSArray* arrayTourismTypeKeys = [_dicHealthTourism allKeys];
    for(id obj in arrayTourismTypeKeys){
        NSMutableDictionary* dicTemp = [_dicHealthTourism objectForKey:obj];
        NSMutableDictionary* dicTemp2 = [dicTemp objectForKey:@"items"];
        NSArray* arrayTemp = [dicTemp2 allKeys];
        
        for (id objTemp in arrayTemp) {
            [_arrayHealthTourism addObject:[dicTemp2 objectForKey:objTemp]];
        }
    }
    
    // 修改分类标签
    [self._btnType setTitle:@"全部" forState:UIControlStateNormal];
    // 显示所有条目
    [self getAllItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayShowItems count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TourismTableViewCell* cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"TourismTableViewCell"];
    
    if (cell == nil)
    {
        cell = [[TourismTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TourismTableViewCell"] ;
    }
    
    // Configure the cell
    NSInteger nRow = indexPath.row;
    NSMutableDictionary* dicTemp = _arrayShowItems[nRow];
    cell._labMotif.text = [dicTemp objectForKey:@"motif"];
    cell._labFeaturesIntroduced.text = [dicTemp objectForKey:@"FeaturesIntroduced"];
    cell._labPrice.text = [dicTemp objectForKey:@"Price"];
    cell._imgFeature.image = [UIImage imageNamed:[dicTemp objectForKey:@"image"]];
    
    return  cell;
}

// 按分类筛选
-(IBAction)btnPressClassificationScreening:(id)sender
{
    // 检索分类类型
    if (_dicClassification.count == 0 ) {
        for (id objTemp in _arrayHealthTourism) {
            NSMutableDictionary* dicTemp = (NSMutableDictionary*)objTemp;
            NSMutableDictionary* dicTemp2 = [dicTemp objectForKey:@"classification"];
            
            [_dicClassification setObject:[dicTemp2 objectForKey:@"motif"] forKey:[dicTemp2 objectForKey:@"tag"]];
        }
    }
    
    // 弹出菜单
    NSMutableArray *menuItems = [[NSMutableArray alloc]init];
    KxMenuItem* menuItem = [KxMenuItem menuItem:@"全部"
                   image:nil
                  target:self
                  action:@selector(pushMenuItem:)
                     tag:@"0"];
    [menuItems addObject:menuItem];
    NSArray* arrayType = [_dicClassification allKeys];
    NSArray* sortKeys = [arrayType sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    for (id obj in sortKeys) {
        menuItem = [KxMenuItem menuItem:[_dicClassification objectForKey:obj]
                                              image:nil
                                             target:self
                                             action:@selector(pushMenuItem:)
                                                tag:obj];
        
        [menuItems addObject:menuItem];
    }
    
    // 菜单起始区域
    CGRect rcBtn = [sender frame];
    CGRect rcMenu = CGRectMake(rcBtn.origin.x, rcBtn.origin.y + rcBtn.size.height / 2, rcBtn.size.width, rcBtn.size.height);
    [KxMenu showMenuInView:self.view
                  fromRect:rcMenu
                 menuItems:menuItems];
}

// 点击菜单选项
- (void) pushMenuItem:(id)sender
{
    [_arrayShowItems removeAllObjects];
    
    KxMenuItem* menuItem = (KxMenuItem*)sender;
    NSString* strTag = menuItem.strTag;
    
    NSString* strType = nil;
    // 全部
    if ([strTag isEqualToString:@"0"]){
        [self getAllItem];
        strType = @"全部";
    }
    else
    {
        for (id objTemp in _arrayHealthTourism) {
            NSMutableDictionary* dicTemp = (NSMutableDictionary*)objTemp;
            NSMutableDictionary* dicTemp2 = [dicTemp objectForKey:@"classification"];
            
            NSString* strTagTemp = [dicTemp2 objectForKey:@"tag"];
            
            if ([strTagTemp isEqualToString:strTag]) {
                [_arrayShowItems addObject:objTemp];
                strType = [dicTemp2 objectForKey:@"motif"];
            }
        }
    }
    
    // 修改分类标签
    [self._btnType setTitle:strType forState:UIControlStateNormal];
    [self._tableView reloadData];
}

// 按分类筛选旅游项目
-(void)getAllItem
{
    [_arrayShowItems removeAllObjects];
    _arrayShowItems = [NSMutableArray arrayWithArray:_arrayHealthTourism];
}

@end
