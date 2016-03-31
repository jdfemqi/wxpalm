//
//  PersonalViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/23.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "PersonalViewController.h"
#import "PopularOptionsCollectionCell.h"
#import "macroDefine.h"
#import "ToolBarItemOrderInfo.h"

@interface PersonalViewController ()
{
    NSMutableDictionary* _dicProvSers;
}
@property (nonatomic, retain)NSArray* provSers;
@property(nonatomic,weak)IBOutlet UIToolbar* _tbOrderInfo;     // 订单信息工具栏
@property (weak, nonatomic) IBOutlet UIImageView *_ivHeadPortrait;      //  头像
@property(nonatomic,weak)IBOutlet UILabel* _labUserName;     // 用户名
@property(nonatomic,weak)IBOutlet UILabel* _labCouponBalance;     // 通券余额
@property(nonatomic,weak)IBOutlet UILabel* _labBalanceOfShopping;// 购物通券余额
@property(nonatomic,weak)IBOutlet UILabel* _labPensionAccountBalance;// 养老账户余额
@property(nonatomic,weak)IBOutlet UILabel* _labIntegral;    // 积分

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"PersonalPopularOptionsInfo" ofType:@"plist"];   // 商品类型
    _dicProvSers = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    NSArray* provSersKeys = [_dicProvSers allKeys];
    
    self.provSers = provSersKeys;
    // 自定义订单信息工具栏
    //[self DesignToolBarOrdersInfo];

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
    static NSString * CellIdentifier = @"PopularOptionsCollectionCell";
    PopularOptionsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // 获取对应描述
    NSInteger nRow = [indexPath row];
    
    NSString* strKey = self.provSers[nRow];
    NSMutableDictionary* dicTemp = [_dicProvSers objectForKey:strKey];
    NSString* strMotif = [dicTemp objectForKey:provideServiceMotif];
    
    cell._labMotif.text = strMotif;
    NSString *strImageName = [dicTemp objectForKey:provideServiceIconName];
    [cell._image setImage:[UIImage imageNamed:strImageName]];
    
    return cell;
}

// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

// 自定义订单信息工具栏
-(void)DesignToolBarOrdersInfo
{
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil] ;
    spaceItem.width = 6;
    
    NSMutableArray *myToolBarItems = [NSMutableArray array];
    [myToolBarItems addObject:spaceItem];
    
    NSArray *buttonNames = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", nil];
    for (int i = 0; i < 4; i++) {
        UIView* toolbaritemView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 30.0f)];
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 15.0f)];
        
        myLabel.font=[UIFont systemFontOfSize:12];
        myLabel.text = buttonNames[i];
        [ toolbaritemView addSubview:myLabel];
        
        UILabel *myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, 45.0f, 15.0f)];
        
        myLabel2.text = @"456";
        myLabel2.font=[UIFont systemFontOfSize:12];
        [toolbaritemView addSubview:myLabel2];
        
        UIBarButtonItem *myButtonItem = [[UIBarButtonItem alloc]initWithCustomView:toolbaritemView];
        
        [myButtonItem setTarget:self];
        [myButtonItem setAction:@selector(btPress:)];
        
        //myButtonItem.customView = toolbaritemView;
        
        [myToolBarItems addObject: myButtonItem];
        
        if (i != 3) {
            spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] ;
            
            [myToolBarItems addObject:spaceItem];
        }
    }
    
     spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil] ;
    spaceItem.width = 6;
    [myToolBarItems addObject:spaceItem];
    
    [self._tbOrderInfo setItems:myToolBarItems animated:YES];

}

// ToolBar中单元点击事件
-(IBAction)btPress:(id)sender
{
    UIButton *btnNil = sender;
    UIView* barButtonItem = [btnNil superview];
    //ToolBarItemOrderInfo* tbOrderInfo = [barButtonItem superview];
    //UILabel* labtest = barButtonItem._labNum;
   // NSString* strTitle = tbOrderInfo._labMotif.text;
    
    UILabel* labMotif = [barButtonItem viewWithTag:1];
    
    self._labUserName.text = labMotif.text;
 }
@end
