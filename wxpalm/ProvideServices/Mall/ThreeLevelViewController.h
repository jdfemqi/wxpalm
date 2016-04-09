//
//  ThreeLevelViewController.h
//  wxpalm
//
//  Created by qiujian on 16/3/24.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  商品结构三级

#import <UIKit/UIKit.h>
#import "ShowNormalNavBarViewController.h"

@interface ThreeLevelViewController : ShowNormalNavBarViewController

@property (nonatomic, retain)NSString* strMotif;     // 主题
@property (nonatomic, retain)NSString* strBriefDes;     // 简介
@property (nonatomic, retain)UIImage* rowImage;     // 行图标
@property (nonatomic, retain)NSString* strThreeLevelPlist;     // 三级结构内容

@property (nonatomic, retain)NSArray* arrayThreeLevelPlist;     // 三级结构内容

@end
