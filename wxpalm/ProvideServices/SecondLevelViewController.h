//
//  SecondLevelViewController.h
//  wxpalm
//
//  Created by qiujian on 16/3/23.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  商品结构二级

#import <UIKit/UIKit.h>

@interface SecondLevelViewController : UITableViewController

@property (nonatomic, retain)NSString* strMotif;     // 主题
@property (nonatomic, retain)NSString* strBriefDes;     // 简介
@property (nonatomic, retain)UIImage* rowImage;     // 行图标
@property (nonatomic, retain)NSString* strThreeLevelPlist;     // 二级结构内容

@end
