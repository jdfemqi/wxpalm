//
//  TVCellDailyFuncCollection.m
//  wxpalm
//
//  Created by qiujian on 16/3/16.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  常用功能列表

#import "TVCellDailyFuncCollection.h"
#import "HomeDFCollectionViewCell.h"
#import "../ProvideServices/HealthTourism/HealthTourismViewController.h"
#import "../macroDefine.h"

@interface TVCellDailyFuncCollection()
{
    NSMutableDictionary* _DailyFuncData;// ToolBar中的常用功能显示数据
}
@end

@implementation TVCellDailyFuncCollection

- (void)awakeFromNib {
    // Initialization code
    
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"DailyFuncInfo" ofType:@"plist"];
    _DailyFuncData = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
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
    
    UIColor* backGround = nil;
    NSInteger nRow = [indexPath row];
    switch (nRow) {
        case 0:
            backGround = [UIColor colorWithRed:255.0f/255.0f green:203.0f/255.0f blue:0.0f/255.0f alpha:1.0];
            break;
            
            case 1:
            backGround = [UIColor colorWithRed:86.0f/255.0f green:149.0f/255.0f blue:255.0f/255.0f alpha:1.0];
            break;
            
            case 2:
            backGround = [UIColor colorWithRed:190.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0];
            break;
            
            case 3:
            backGround = [UIColor colorWithRed:81.0f/255.0f green:223.0f/255.0f blue:170.0f/255.0f alpha:1.0];
            break;
            
            case 4:
            backGround = [UIColor colorWithRed:255.0f/255.0f green:185.0f/255.0f blue:255.0f/255.0f alpha:1.0];
            break;
            
            case 5:
            backGround = [UIColor colorWithRed:161.0f/255.0f green:250.0f/255.0f blue:255.0f/255.0f alpha:1.0];
            break;
            
        default:
            break;
    }
    cell.backgroundColor = backGround;
    
    // 获取对应描述
    NSArray* dfKeys = [_DailyFuncData allKeys];
    NSArray* sortKeys = [dfKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString* strKey = sortKeys[nRow];
    
    NSMutableDictionary* dicTemp = [_DailyFuncData objectForKey:strKey];
    cell._strKey = strKey;
    // 更新Cell的显示
    [cell updateView:dicTemp];

    return cell;
}

// 定义cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize szFrame = collectionView.frame.size;
    return CGSizeMake((szFrame.width)/2 - 2, 60);
}

#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDFCollectionViewCell * cell = (HomeDFCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* strKey = cell._strKey;
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"ProvideServices" object:nil userInfo:@{@"1":strKey}];
    
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

@end
