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
@end
@implementation TVCellDailyFuncCollection

- (void)awakeFromNib {
    // Initialization code
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
