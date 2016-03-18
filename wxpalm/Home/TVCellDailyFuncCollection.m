//
//  TVCellDailyFuncCollection.m
//  wxpalm
//
//  Created by qiujian on 16/3/16.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  常用功能列表

#import "TVCellDailyFuncCollection.h"
#import "HomeDFCollectionViewCell.h"

@interface TVCellDailyFuncCollection()
{
    NSMutableArray* _DailyFuncData;// ToolBar中的常用功能显示数据
    NSMutableDictionary* _provideSerivcesInfo;// 提供的所有服务信息
}
@end

@implementation TVCellDailyFuncCollection

- (void)awakeFromNib {
    // Initialization code
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"DailyFuncInfo" ofType:@"plist"];
    _DailyFuncData = [NSMutableArray arrayWithContentsOfFile:_plistPath];
    
    
    NSString* _pProvideSerInfoPath = [[NSBundle mainBundle]pathForResource:@"ProvideServicesInfo" ofType:@"plist"];
    _provideSerivcesInfo = [NSMutableDictionary dictionaryWithContentsOfFile:_pProvideSerInfoPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"HomeDFCollectionCell";
    HomeDFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    // 获取对应描述
    NSInteger nRow = [indexPath row];
    NSMutableDictionary* dicTemp = [_provideSerivcesInfo objectForKey:_DailyFuncData[nRow]];
    
    // 更新Cell的显示
    [cell updateView:dicTemp];

    return cell;
}

// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize szFrame = collectionView.frame.size;
    return CGSizeMake((szFrame.width - 16)/2 - 2, 60);
}

#pragma mark <UICollectionViewDelegate>

@end
