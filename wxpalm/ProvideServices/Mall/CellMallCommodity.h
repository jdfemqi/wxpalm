//
//  CellMallCommodity.h
//  wxpalm
//
//  Created by qiujian on 16/3/24.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMallCommodity : UITableViewCell
{
    __weak IBOutlet UILabel *_labBriefDes;
    __weak IBOutlet UILabel *_labMotif;
    __weak IBOutlet UIImageView *_commodityIcon;
}

@property (nonatomic, retain)UIImageView *_commodityIcon;    // 行图标
@property (nonatomic, retain)UILabel *_labMotif;     // 商品主题
@property (nonatomic, retain)UILabel *_labBriefDes;     // 商品描述

@end
