//
//  ProvideServicesViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/23.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "ProvideServicesViewController.h"
#import "ProvSerCollectionCell.h"
#import "macroDefine.h"
#import "CareersServiceViewController.h"
#import "IntegratedMallViewController.h"
#import "HealthTourismViewController.h"
#import "IntegralExchangeViewController.h"
#import "IntegralLuckyDrawViewController.h"
#import "HydropowerPaymentViewController.h"
#import "AddCreditViewController.h"
#import "CreditCardPaymentViewController.h"
#import "TicketOrderingViewController.h"
#import "HotelBookingViewController.h"
#import "MyCollectionViewController.h"
#import "AttractionsTicketsViewController.h"

@interface ProvideServicesViewController ()
{
    NSMutableDictionary* _dicProvSers;
    NSArray* _provSers;
    CareersServiceViewController* _csViewController;        // 就业服务
    IntegratedMallViewController* _IntegratedMall;          // 综合商城
    HealthTourismViewController* _HTViewController;         // 养生旅游
    IntegralExchangeViewController* _integralExchangeVC;    // 积分兑换
    IntegralLuckyDrawViewController* _IntegralLuckyDrawVC;  // 积分抽奖
    HydropowerPaymentViewController* _HydropowerPaymentVC;  // 水电缴费
    AddCreditViewController* _AddCreditVC;                  // 手机充值
    CreditCardPaymentViewController* _CreditCardPaymentVC;  // 信用卡还款
    TicketOrderingViewController* _TicketOrderingVC;        // 火车票
    HotelBookingViewController* _HotelBookingVC;            // 酒店
    MyCollectionViewController* _MyCollectionVC;            // 我的收藏
    AttractionsTicketsViewController* _AttractionsTicketsVC;// 景点门票
}

@end

@implementation ProvideServicesViewController

- (void)awakeFromNib {
    // Initialization code
    /*
     当.nib文件被加载的时候，会发送一个awakeFromNib的消息到.nib文件中的每个对象
     当一个viewcontroller绑定多个storyboard实例时，此方法会被多次调用*/
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    // storyboard创建的对象调用此方法初始化
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _csViewController = nil;
        _IntegratedMall = nil;
        _HTViewController = nil;
        
        // 获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(notice:) name:@"ProvideServices" object:nil];
    }
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"ProvideServicesInfo" ofType:@"plist"];   // 商品类型
    _dicProvSers = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    NSArray* provSersKeys = [_dicProvSers allKeys];
    
    _provSers = provSersKeys;
    
    return self;
}

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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_provSers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ProvSerCollectionCell";
    ProvSerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // 获取对应描述
    NSInteger nRow = [indexPath row];
    
    NSString* strKey = _provSers[nRow];
    NSMutableDictionary* dicTemp = [_dicProvSers objectForKey:strKey];
    NSString* strMotif = [dicTemp objectForKey:provideServiceMotif];
    
    cell._labMotif.text = strMotif;
    NSString *strImageName = [dicTemp objectForKey:provideServiceIconName];
    [cell.ivPSCell setImage:[UIImage imageNamed:strImageName]];
    cell._strKey = strKey;
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView*)collectionView shouldSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   // BOOL bRet = FALSE;
    return TRUE;
}



// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProvSerCollectionCell * cell = (ProvSerCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* strKey = cell._strKey;
    
    // 子界面
    [self selectService:strKey];
}

-(void)selectService:(NSString*)strKey
{
    NSMutableDictionary* dicTemp = [_dicProvSers objectForKey:strKey];
    
    UIViewController* pViewController = nil;
    
    if ([strKey isEqualToString:PSHydropowerPayment])  // 水电缴费
    {
        if ( _HydropowerPaymentVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _HydropowerPaymentVC = [psStoryboard instantiateViewControllerWithIdentifier:@"HydropowerPayment"];
        }
        
        pViewController = _HydropowerPaymentVC;
    }
    else if([strKey isEqualToString:PSAddCredit])// 手机充值
    {
        if ( _AddCreditVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _AddCreditVC = [psStoryboard instantiateViewControllerWithIdentifier:@"AddCredit"];
        }
        
        pViewController = _AddCreditVC;
    }
    else if([strKey isEqualToString:PSCreditCardPayment])// 信用卡还款
    {
        if ( _CreditCardPaymentVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _CreditCardPaymentVC = [psStoryboard instantiateViewControllerWithIdentifier:@"CreditCardPayment"];
        }
        
        pViewController = _CreditCardPaymentVC;
    }
    else if ([strKey isEqualToString:PSHealthTourism])  // 养生旅游
    {
        if ( _HTViewController == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _HTViewController = [psStoryboard instantiateViewControllerWithIdentifier:@"HealthTourismViewController"];
        }
        
        pViewController = _HTViewController;
    }
    else if ([strKey isEqualToString:PSIntegratedMall])  // 综合商城
    {
        if (_IntegratedMall == nil) {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _IntegratedMall = [psStoryboard instantiateViewControllerWithIdentifier:@"IntegratedMall"];
        }
        
        pViewController = _IntegratedMall;
    }
    else if([strKey isEqualToString:PSCareersService])// 就业服务
    {
        if ( _csViewController == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _csViewController = [psStoryboard instantiateViewControllerWithIdentifier:@"PSCareersService"];
        }
        
        pViewController = _csViewController;
    }
    else if([strKey isEqualToString:PSTicketOrdering])// 火车票
    {
        if ( _TicketOrderingVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _TicketOrderingVC = [psStoryboard instantiateViewControllerWithIdentifier:@"TicketOrdering"];
        }
        
        pViewController = _TicketOrderingVC;
    }
    else if ([strKey isEqualToString:PSIntegralLuckyDraw])  // 积分抽奖
    {
        if ( _IntegralLuckyDrawVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _IntegralLuckyDrawVC = [psStoryboard instantiateViewControllerWithIdentifier:@"IntegralLuckyDraw"];
        }
        
        pViewController = _IntegralLuckyDrawVC;
    }
    else if ([strKey isEqualToString:PSHotelBooking])  // 酒店
    {
        if ( _HotelBookingVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _HotelBookingVC = [psStoryboard instantiateViewControllerWithIdentifier:@"HotelBooking"];
        }
        
        pViewController = _HotelBookingVC;
    }
    else if ([strKey isEqualToString:PSMyCollection])  // 我的收藏
    {
        if ( _MyCollectionVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _MyCollectionVC = [psStoryboard instantiateViewControllerWithIdentifier:@"MyCollection"];
        }
        
        pViewController = _MyCollectionVC;
    }
    else if ([strKey isEqualToString:PSIntegralExchange])  // 积分兑换
    {
        if ( _integralExchangeVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _integralExchangeVC = [psStoryboard instantiateViewControllerWithIdentifier:@"IntegralExchange"];
        }
        
        pViewController = _integralExchangeVC;
    }
    else if ([strKey isEqualToString:PSAttractionsTickets])  // 景点门票
    {
        if ( _AttractionsTicketsVC == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _AttractionsTicketsVC = [psStoryboard instantiateViewControllerWithIdentifier:@"AttractionsTickets"];
        }
        
        pViewController = _AttractionsTicketsVC;
    }
    
    
    // 设置nav bar标题
    pViewController.title = [dicTemp objectForKey:@"title"];
    
    // 加入navigationController显示
    [self.navigationController pushViewController:pViewController animated:YES];
}

-(void)notice:(NSNotification *)noti
{
    // 获取值
    NSDictionary *noKey = [noti userInfo];
    NSString* strKey = [noKey objectForKey:@"1"];
    
    [self selectService:strKey];
}

@end
