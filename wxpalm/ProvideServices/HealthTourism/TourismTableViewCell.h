//
//  TourismTableViewCell.h
//  wxpalm
//
//  Created by qiujian on 16/3/31.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourismTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *_imgFeature;      // 特色图片
@property (weak, nonatomic) IBOutlet UILabel *_labMotif;        // 简介
@property (weak, nonatomic) IBOutlet UILabel *_labFeaturesIntroduced;     // 特色介绍
@property (weak, nonatomic) IBOutlet UILabel *_labPrice;        // 价钱

@end
