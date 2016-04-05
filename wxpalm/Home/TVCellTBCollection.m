//
//  TVCellTBCollection.m
//  wxpalm
//
//  Created by qiujian on 16/3/14.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "TVCellTBCollection.h"
#import "HomeTBCollectionViewCell.h"
#import "macroDefine.h"
#import "CareersServiceViewController.h"
#import "IntegratedMallViewController.h"
#import "../AppDelegate.h"

@interface TVCellTBCollection()
{
    NSMutableDictionary* _homeTBData;// ToolBar中的常用功能显示数据
    
    NSMutableDictionary* _provideSerivcesInfo;// 提供的所有服务信息
    
    CareersServiceViewController* _csViewController;    // 就业服务
    IntegratedMallViewController* _IntegratedMall;// 综合商城
}
@end

@implementation TVCellTBCollection

- (void)awakeFromNib {
    // Initialization code
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"homeTBInfo" ofType:@"plist"];
    _homeTBData = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    NSString* _pProvideSerInfoPath = [[NSBundle mainBundle]pathForResource:@"ProvideServicesInfo" ofType:@"plist"];
    _provideSerivcesInfo = [NSMutableDictionary dictionaryWithContentsOfFile:_pProvideSerInfoPath];
    
    _csViewController = nil;
    _IntegratedMall = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"HomeTBCollectionCell";
    HomeTBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // 获取对应描述
    NSInteger nRow = [indexPath row];
    NSArray* TBKeys = [_homeTBData allKeys];
    NSArray* sortKeys = [TBKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString* strKey = [_homeTBData objectForKey:sortKeys[nRow]];
    NSMutableDictionary* dicTemp = [_provideSerivcesInfo objectForKey:strKey];
    
    cell._strKey = strKey;
    
    // 更新Cell的显示
    [cell updateView:dicTemp];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTBCollectionViewCell * cell = (HomeTBCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* strKey = cell._strKey;
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"ProvideServices" object:nil userInfo:@{@"1":strKey}];
    
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

@end
