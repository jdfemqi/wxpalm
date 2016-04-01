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
    NSMutableDictionary* _provideSerivcesInfo;// 提供的所有服务信息
    
    HealthTourismViewController* _HTViewController;
}
@end

@implementation TVCellDailyFuncCollection

- (void)awakeFromNib {
    // Initialization code
    _HTViewController = nil;
    // 读取程序包中的资源文件
    NSString* _plistPath = [[NSBundle mainBundle]pathForResource:@"DailyFuncInfo" ofType:@"plist"];
    _DailyFuncData = [NSMutableDictionary dictionaryWithContentsOfFile:_plistPath];
    
    
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
    NSArray* dfKeys = [_DailyFuncData allKeys];
    NSArray* sortKeys = [dfKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString* strKey = [_DailyFuncData objectForKey:sortKeys[nRow]];
    
    NSMutableDictionary* dicTemp = [_provideSerivcesInfo objectForKey:strKey];
    cell._strKey = strKey;
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
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDFCollectionViewCell * cell = (HomeDFCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString* strKey = cell._strKey;
    NSMutableDictionary* dicTemp = [_provideSerivcesInfo objectForKey:strKey];
    
    UIViewController* pViewController = nil;
    
    // 养生旅游
    if([strKey isEqualToString:PSHealthTourism])
    {
        if ( _HTViewController == nil)
        {
            UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"ProvideServices" bundle:nil];
            _HTViewController = [psStoryboard instantiateViewControllerWithIdentifier:@"HealthTourismViewController"];
        }
        
        pViewController = _HTViewController;
    }
    
    // 设置nav bar标题
    pViewController.title = [dicTemp objectForKey:@"motif"];
    
    // 加入navigationController显示
    UIViewController* pSuperViewControll = nil;
    for (UIView* next = self.superview; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            pSuperViewControll = (UIViewController*)nextResponder;
            break;
        }
    }
    
    [pSuperViewControll.navigationController pushViewController:pViewController animated:YES];
}

@end
