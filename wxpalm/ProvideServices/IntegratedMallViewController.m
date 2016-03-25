//
//  IntegratedMallViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/23.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "IntegratedMallViewController.h"
#import "SecondLevelViewController.h"
#import "CellMallCommodity.h"

#define PSTVCellCommodity   @"PSTVCellCommodity"    // 商品条目自定义

@interface IntegratedMallViewController ()
{
    NSMutableDictionary* _dicCommodityType;
    
    NSInteger _nCommodityType;
    
}

@property (nonatomic, retain)NSArray* controllers;

@end

@implementation IntegratedMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"PSCommodityType" ofType:@"plist"];   // 商品类型
    _dicCommodityType = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    NSArray* commodityTypeKeys = [_dicCommodityType allKeys];
    NSArray* sortKeys = [commodityTypeKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
     for(id obj in sortKeys)
     {
         NSMutableDictionary* dicTemp = [_dicCommodityType objectForKey:obj];
         
         // 各种商品
         UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
         SecondLevelViewController* commodityController = [psStoryboard instantiateViewControllerWithIdentifier:@"SecondLevelViewController"];
         
         commodityController.strMotif = [dicTemp objectForKey:@"motif"];
         commodityController.strBriefDes = [dicTemp objectForKey:@"briefDes"];
         NSString* strIconName =[dicTemp objectForKey:@"iconName"];
         commodityController.rowImage = [UIImage imageNamed:strIconName];
         commodityController.strThreeLevelPlist = obj;
         
         [array addObject:commodityController];
     }
    
    self.controllers = array;
    _nCommodityType = [array count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:FALSE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nCommodityType;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellMallCommodity* cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"MallCellCommodity"];
    
    if (cell == nil)
    {
        cell = [[CellMallCommodity alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MallCellCommodity"] ;
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    SecondLevelViewController* controller = [self.controllers objectAtIndex:row];
    
    cell._labMotif.text = controller.strMotif;
    cell._labBriefDes.text = controller.strBriefDes;
    cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor redColor];

    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    SecondLevelViewController* nextController = [self.controllers objectAtIndex:row];
    
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
