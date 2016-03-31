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

@interface ProvideServicesViewController ()
{
    NSMutableDictionary* _dicProvSers;
}
@property (nonatomic, retain)NSArray* provSers;

@end

@implementation ProvideServicesViewController

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
    
    return cell;
}

// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

@end
