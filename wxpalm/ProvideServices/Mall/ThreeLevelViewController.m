//
//  ThreeLevelViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/24.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "ThreeLevelViewController.h"
#import "FourLevelViewController.h"

@interface ThreeLevelViewController ()
{
    NSMutableDictionary* _dicCommodityType;
    
    NSInteger _nCommodityType;
}

@property (nonatomic, retain)NSArray* controllers;

@end

@implementation ThreeLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    self.controllers = array;
    
    NSArray* sortKeys = self.arrayThreeLevelPlist;
    
    for(id obj in sortKeys)
    {
        NSMutableDictionary* dicTemp = [_dicCommodityType objectForKey:obj];
        
        // 各种商品
        UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
        FourLevelViewController* commodityController = [psStoryboard instantiateViewControllerWithIdentifier:@"FourLevelViewController"];
        
        commodityController.strMotif = obj;
        commodityController.title = commodityController.strMotif;
        
        [array addObject:commodityController];
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

#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* RootViewControllerCell = @"ThreeLevelViewControllerCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCell];
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    FourLevelViewController* controller = [self.controllers objectAtIndex:row];
    
    cell.textLabel.text = controller.strMotif;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    FourLevelViewController* nextController = [self.controllers objectAtIndex:row];
    
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"BestSellersCollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

@end
