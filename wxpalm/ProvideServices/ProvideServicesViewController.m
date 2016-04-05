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

@interface ProvideServicesViewController ()
{
    NSMutableDictionary* _dicProvSers;
    CareersServiceViewController* _csViewController;    // 就业服务
    IntegratedMallViewController* _IntegratedMall;// 综合商城
}
@property (nonatomic, retain)NSArray* provSers;

@end

@implementation ProvideServicesViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibNameOrNil];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"ProvideServices" object:nil];
    
    return  self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(id)init
{
    self = [super init];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"ProvideServices" object:nil];
    
    return self;
}

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"ProvideServicesInfo" ofType:@"plist"];   // 商品类型
    _dicProvSers = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    NSArray* provSersKeys = [_dicProvSers allKeys];
    
    self.provSers = provSersKeys;
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
    return [self.provSers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ProvSerCollectionCell";
    ProvSerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // 获取对应描述
    NSInteger nRow = [indexPath row];
    
    NSString* strKey = self.provSers[nRow];
    NSMutableDictionary* dicTemp = [_dicProvSers objectForKey:strKey];
    NSString* strMotif = [dicTemp objectForKey:provideServiceMotif];
    
    cell._labMotif.text = strMotif;
    NSString *strImageName = [dicTemp objectForKey:provideServiceIconName];
    [cell.ivPSCell setImage:[UIImage imageNamed:strImageName]];
    cell._strKey = strKey;
    
    return cell;
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
    
    [self selectService:strKey];
}

-(void)selectService:(NSString*)strKey
{
    NSMutableDictionary* dicTemp = [_dicProvSers objectForKey:strKey];
    
    UIViewController* pViewController = nil;
    
    //创建一个消息对象
   // NSNotification * notice = [NSNotification notificationWithName:@"ProvideServices" object:nil userInfo:@{@"1":strKey}];
    //发送消息
    //[[NSNotificationCenter defaultCenter]postNotification:notice];
    
    // 就业服务
    if([strKey isEqualToString:PSCareersService])
    {
        if ( _csViewController == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _csViewController = [psStoryboard instantiateViewControllerWithIdentifier:@"PSCareersService"];
        }
        
        pViewController = _csViewController;
    }
    else if ([strKey isEqualToString:PSIntegratedMall])  // 综合商城
    {
        if (_IntegratedMall == nil) {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _IntegratedMall = [psStoryboard instantiateViewControllerWithIdentifier:@"IntegratedMallViewController"];
        }
        
        pViewController = _IntegratedMall;
    }
    
    // 设置nav bar标题
    pViewController.title = [dicTemp objectForKey:@"motif"];
    
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
