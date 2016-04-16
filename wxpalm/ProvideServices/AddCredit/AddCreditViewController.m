//
//  AddCreditViewController.m
//  wxpalm
//
//  Created by qiujian on 16/4/9.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "AddCreditViewController.h"
#import "../../UIComboBox.framework/Headers/UIComboBoxView.h"
//#import "UIComboBoxView.h"

@interface AddCreditViewController ()
{
    UIComboBoxView* MRACmbView;
    UITextField* tfText;
    UIButton* btnDropDown;
}
@property (weak, nonatomic) IBOutlet UIView *viewMobilePhone;   // 手机话费
@property (weak, nonatomic) IBOutlet UIView *viewQQRecharge;    // QQ充值
@property (weak, nonatomic) IBOutlet UIView *viewGameCards;     // 游戏点卡

@property (weak, nonatomic) IBOutlet UIView *viewMobileRechargAmount;  // 手机充值金额
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;   // 手机号码

@end

@implementation AddCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建单元
    MRACmbView = [[UIComboBoxView alloc]initWithFrame:self.viewMobileRechargAmount.bounds];
    [MRACmbView configClickHiddenView:self.view];
    
    [self.viewMobileRechargAmount addSubview:MRACmbView];
    
    // 添加选择条目
    [MRACmbView addItem:@"请选择充值金额" :nil];
    [MRACmbView addItem:@"30元" :nil];
    [MRACmbView addItem:@"50元" :nil];
    [MRACmbView addItem:@"100元" :nil];
    
    NSLog(@"OK");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 AutoLayout状态下，执行完viewDidLoad、viewWillAppear等方法后，还会执行viewDidLayoutSubviews方法
 详见：http://blog.csdn.net/heartofthesea/article/details/46429211
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 重设手机充值金额ComboBox
    MRACmbView.frame = self.viewMobileRechargAmount.bounds;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
