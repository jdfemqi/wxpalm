//
//  FourLevelViewController.h
//  wxpalm
//
//  Created by qiujian on 16/3/25.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  商品四级分类

#import <UIKit/UIKit.h>
#import "ShowNormalNavBarViewController.h"

@interface FourLevelViewController : ShowNormalNavBarViewController

@property (nonatomic, retain)NSString* strMotif;     // 主题

-(IBAction)btPress:(id)sender;

@end
