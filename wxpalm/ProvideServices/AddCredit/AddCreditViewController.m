//
//  AddCreditViewController.m
//  wxpalm
//
//  Created by qiujian on 16/4/9.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "AddCreditViewController.h"
//#import "../../UIComboBox.framework/Headers/UIComboBoxView.h"
//#import "UIComboBoxView.h"
#import "../../CustomControls.framework/Headers/ZYRadioButton.h"
#import "../../CustomControls.framework/Headers/UIComboBoxView.h"
//#import "ZYRadioButton.h"

@interface AddCreditViewController ()
{
    UIComboBoxView* MRACmbView;
    UITextField* tfText;
    UIButton* btnDropDown;
    
    NSLayoutConstraint *constraint;
    ZYRadioButton* zyrbOnlinePayment;
    ZYRadioButton* zyrbBalancePayment;
}
@property (weak, nonatomic) IBOutlet UIView *viewMobilePhone;   // 手机话费
@property (weak, nonatomic) IBOutlet UIView *viewQQRecharge;    // QQ充值
@property (weak, nonatomic) IBOutlet UIView *viewGameCards;     // 游戏点卡

@property (weak, nonatomic) IBOutlet UIView *viewMobileRechargAmount;  // 手机充值金额
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;   // 手机号码

@property (weak, nonatomic) IBOutlet UITableView *tblViewMobileInfoDisplay; //手机信息展示

@property (weak, nonatomic) IBOutlet UIView *viewPaymentTypeSel; // 支付类型选择
@property (weak, nonatomic) IBOutlet UIView *rbOnlinePayment;   // 在线支付
@property (weak, nonatomic) IBOutlet UIView *rbBalancePayment;  // 余额支付
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
    MRACmbView.delegate = self;
    
    // tableView属性设置(圆角边框)
    self.tblViewMobileInfoDisplay.layer.cornerRadius = 5;
    self.tblViewMobileInfoDisplay.layer.borderWidth = 1;
    self.tblViewMobileInfoDisplay.layer.borderColor = [[UIColor blackColor] CGColor];//设置列表边框
    self.tblViewMobileInfoDisplay.separatorColor = [UIColor redColor];//设置行间隔边框
    self.tblViewMobileInfoDisplay.scrollEnabled = FALSE;        // 不可滚动
    
    // 支付类型选择
    self.viewPaymentTypeSel.layer.cornerRadius = 5;
    self.viewPaymentTypeSel.layer.borderWidth = 1;
    self.viewPaymentTypeSel.layer.borderColor = [[UIColor blackColor] CGColor];//设置列表边框
    
    [self.tblViewMobileInfoDisplay setHidden:YES];
    
    // 初始化单选按钮控件
    zyrbOnlinePayment = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:0];
    zyrbBalancePayment = [[ZYRadioButton alloc] initWithGroupId:@"first group" index:1];
    [zyrbOnlinePayment setText:@"在线支付"];
    [zyrbBalancePayment setText:@"余额支付"];
    // 添加约束
    [self.viewPaymentTypeSel addSubview:zyrbOnlinePayment];
    [self.viewPaymentTypeSel addSubview:zyrbBalancePayment];
    
    constraint = nil;
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
    
    if (self.tblViewMobileInfoDisplay.hidden == YES) {
        // 修改约束(支付类型选择与充值金额之间的重直距离)
        [self.view removeConstraint:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:self.viewPaymentTypeSel
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.viewMobileRechargAmount
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0f
                                                   constant:8];
        [self.view addConstraint:constraint];
    }
    else
    {
        // 修改约束(支付类型选择与手机信息展示视图之间的重直距离)
        [self.view removeConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:self.viewPaymentTypeSel
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.tblViewMobileInfoDisplay
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0f
                                                   constant:8];
        [self.view addConstraint:constraint];
    }
    
    // 支付方式
    zyrbBalancePayment.frame = self.rbBalancePayment.frame;
    zyrbOnlinePayment.frame = self.rbOnlinePayment.frame;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 手机信息展示
#pragma mark Table Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* RootViewControllerCell = @"MobileInfoDisplay";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCell];
    }
    
    // Configure the cell
   // NSUInteger row = [indexPath row];
   //FourLevelViewController* controller = [self.controllers objectAtIndex:row];
    
    cell.textLabel.text = @"123";
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

// 充值金额变化
- (void) selChange: (NSInteger) nItem
{
    if (nItem != 0 && (self.tblViewMobileInfoDisplay.hidden == YES))
    {
        [self.tblViewMobileInfoDisplay setHidden:NO];
        
    }
}

@end
