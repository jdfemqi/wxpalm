//
//  TVCellTBCollection.m
//  wxpalm
//
//  Created by qiujian on 16/3/14.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "TVCellTBCollection.h"
#import "HomeTBCollectionViewCell.h"

@interface TVCellTBCollection()
{
    NSMutableDictionary* _homeTBData;// ToolBar中的常用功能显示数据
    
    NSMutableDictionary* _provideSerivcesInfo;// 提供的所有服务信息
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
    NSArray* arrayTB = [_homeTBData allKeys];
    NSString* strKey = [_homeTBData objectForKey:arrayTB[nRow]];
    NSMutableDictionary* dicTemp = [_provideSerivcesInfo objectForKey:strKey];
    
    // 更新Cell的显示
    [cell updateView:dicTemp];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

@end