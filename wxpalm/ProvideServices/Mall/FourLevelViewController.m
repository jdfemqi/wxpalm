//
//  FourLevelViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/25.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "FourLevelViewController.h"

@interface FourLevelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labBarButtonItem;

@end

@implementation FourLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
