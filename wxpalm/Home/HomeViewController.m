//
//  HomeViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/11.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HomeViewController.h"
#import "TVCellTBCollection.h"
#import "TVCellIAMIC.h"
#import "TVCellDailyFuncCollection.h"
#import "./IAMIC.framework/Headers/IAMICObject.h"


#define CellTBCollectionIdentifier  @"CellTBCollectionIdentifier"       // 常用功能工具条
#define CellIAMIC                   @"CellIAMIC"                        // 广告循环
#define CellDailyFunc               @"CellDailyFunc"                    // 常用功能列表
@interface HomeViewController ()
{
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:TRUE];
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
    UITableViewCell* cell = nil;
    //获取UIStoryboard对象
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch ([indexPath row]) {
        case 0:             // 常用功能工具条
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellTBCollectionIdentifier];
            if (cell == nil)
            {
                //cell = [mainStoryboard instantiateViewControllerWithIdentifier:CellTBCollectionIdentifier];
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTBCollectionIdentifier] ;
            }
        }
        break;
            
        case 1:         // 广告循环
        {
            TVCellIAMIC* cellIAMIC = [tableView dequeueReusableCellWithIdentifier:CellIAMIC];
            if (cellIAMIC == nil)
            {
                //cellIAMIC = [mainStoryboard instantiateViewControllerWithIdentifier:CellIAMIC];
                
                 cellIAMIC = [[TVCellIAMIC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIAMIC] ;

            }
            

            
            [cellIAMIC setConfig:tableView :indexPath];
            cell = cellIAMIC;
            
        }
            break;
            
        case 2:         // 常用功能列表
        {
            TVCellDailyFuncCollection* TVcellDFC = [tableView dequeueReusableCellWithIdentifier:CellDailyFunc];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellDailyFunc] ;
                //cell = [mainStoryboard instantiateViewControllerWithIdentifier:CellDailyFunc];
            }
            
            cell = TVcellDFC;
        }
            break;
            
        default:
            break;
    }
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = 30;
    switch ([indexPath row]) {
        case 0:
            heightForRow =  60;
            break;
            
        case 1:
            heightForRow = 150;
            break;
            
        case 2:
            heightForRow = 190;
            break;
            
        default:
            break;
    }
    return heightForRow;
}


@end
