//
//  FourLevelViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/25.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "FourLevelViewController.h"
#import "ProductDetailsViewController.h"

@interface FourLevelViewController ()
{
    ProductDetailsViewController* _pdController;    // 商品详情
}
@property (weak, nonatomic) IBOutlet UILabel *labBarButtonItem;

@end

@implementation FourLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 商品详情
    UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
    _pdController = [psStoryboard instantiateViewControllerWithIdentifier:@"ProductDetailsViewController"];
    _pdController.title = @"商品详情";
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

// ToolBar中单元点击事件
-(IBAction)btPress:(id)sender
{
    UIBarButtonItem *barButtonItem = sender;
    NSString* strTitle = barButtonItem.title;
    _labBarButtonItem.text = strTitle;
}
#pragma mark -
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* FourLevelViewControllerCell = @"FourLevelViewControllerCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FourLevelViewControllerCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FourLevelViewControllerCell];
    }
    
    // Configure the cell
    NSInteger index = indexPath.row;
    NSString* strTest = [NSString stringWithFormat:@"test%d", index];
    cell.textLabel.text = strTest;
    
    return  cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    [self.navigationController pushViewController:_pdController animated:YES];
}

@end
