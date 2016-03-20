//
//  HomeDFCollectionViewCell.m
//  wxpalm
//
//  Created by qiujian on 16/3/16.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HomeDFCollectionViewCell.h"
#import "macroDefine.h"

@interface HomeDFCollectionViewCell()
{
    __weak IBOutlet UIImageView *_iconFunc; // 功能图标
    __weak IBOutlet UILabel *_lbMotif;    // 主题
    __weak IBOutlet UILabel *lbBrieDes;     // 简要描述
}

@end

@implementation HomeDFCollectionViewCell

-(void)updateView:(NSMutableDictionary*)dicTemp
{
    // UILabel文本
    _lbMotif.text = [dicTemp objectForKey:provideServiceMotif];
    lbBrieDes.text = [dicTemp objectForKey:provideServiceBriefDes];
    
    // 图标
    NSString *strImageName = [dicTemp objectForKey:provideServiceIconName];
    [_iconFunc setImage:[UIImage imageNamed:strImageName]];
}

@end
