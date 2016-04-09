//
//  UIBaseNavigationBar.h
//  wxpalm
//
//  Created by qiujian on 16/4/7.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  自定义基础导航条

#import <UIKit/UIKit.h>

@interface UIBaseNavigationBar : UINavigationBar

+ (UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title;

@end
