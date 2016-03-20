//
//  HomeTBCollectionViewCell.m
//  wxpalm
//
//  Created by qiujian on 16/3/15.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "HomeTBCollectionViewCell.h"
#import "macroDefine.h"

@implementation HomeTBCollectionViewCell

-(void)updateView:(NSMutableDictionary*)dicTemp
{
    self.backgroundColor = [UIColor redColor];
    
    // UILabel设置背景图片
    // UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"itemkaung2.png"]];
    //[cell.lbHomeTBCell setBackgroundColor:color];
    
    // UILabel文本
    self.lbHomeTBCell.text = [dicTemp objectForKey:provideServiceMotif];
    
    // 图标
    NSString *strImageName = [dicTemp objectForKey:provideServiceIconName];
    [self.ivHomeTBCell setImage:[UIImage imageNamed:strImageName]];

}
@end
