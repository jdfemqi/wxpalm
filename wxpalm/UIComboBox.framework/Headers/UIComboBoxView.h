//
//  UIComboBoxView.h
//  UIComboBox
//
//  Created by qiujian on 16/4/12.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIComboBoxView : UIView

// 点击隐藏窗口
-(void)configClickHiddenView:(UIView*)viewSuper;

// 控件显示区域
-(void)setFrame:(CGRect)frame;

// 添加条目
-(void)addItem:(NSString*)strTitle :(UIImage*)image;
@end
