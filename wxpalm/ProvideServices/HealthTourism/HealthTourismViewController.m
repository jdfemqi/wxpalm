//
//  HealthTourismViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/31.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HealthTourismViewController.h"
#import "TourismTableViewCell.h"

@interface HealthTourismViewController ()
{
    NSMutableDictionary* _dicHealthTourism;
    NSMutableArray* _arrayHealthTourism;
}

@end

@implementation HealthTourismViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayHealthTourism = [[NSMutableArray alloc]init];
    
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
    return [_arrayHealthTourism count];
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
    NSMutableDictionary* dicTemp = _arrayHealthTourism[nRow];
    cell._labMotif.text = [dicTemp objectForKey:@"motif"];
    cell._labFeaturesIntroduced.text = [dicTemp objectForKey:@"FeaturesIntroduced"];
    cell._labPrice.text = [dicTemp objectForKey:@"Price"];
    cell._imgFeature.image = [UIImage imageNamed:[dicTemp objectForKey:@"image"]];
    
    return  cell;
}

@end
