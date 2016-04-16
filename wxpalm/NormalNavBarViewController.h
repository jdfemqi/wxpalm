//
//  NormalNavBarViewController.h
//  wxpalm
//
//  Created by qiujian on 16/4/8.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//  自定义NavBar
//  标准NavBar自定义问题：1.返回按钮的响应区域较大；2.主动修改状态栏背景；3.等
/*
 在iOS7，由于状态栏背景透明，那么，导航栏背景就可能要兼职充当状态栏背景了
 详解：http://www.cnblogs.com/jerny/articles/4433429.html
 
 问题：设置了UINavigationBar的background image，现象为状态栏一直是一片漆黑
 原因：意思就是UINavigationBar的高度会自行调整为44或者64，没有确定的预测方法。而之前作为UINavigationBar背景的图片是44高度的。最后换了张64高度，上面留了20px透明的图片搞定
 // NavBar背景设置
 UINavigationBar* navBar = self.navigationController.navigationBar;
 if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
 
   [navBar setBackgroundImage:[UIImage imageNamed:@"nav_background.png"] forBarMetrics:UIBarMetricsDefault];
 }
 
 // 统一修改buttonItem
 //创建UIBarButtonItem
 UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
 
 NSMutableArray* arrBarItems = [[NSMutableArray alloc]init];
 [arrBarItems addObject:leftButton];
 self.navigationController.navigationItem.leftBarButtonItem = leftButton;
 
 // 统一返回按钮
 UIImage *imageBack = [UIImage imageNamed:@"ic_back.png"];
 [[UIBarButtonItem appearance]setBackButtonBackgroundImage:[imageBack resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)]  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
 
 // 隐藏返回按钮上的文本
 [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
 */

#import <UIKit/UIKit.h>

@interface NormalNavBarViewController : UIViewController

@property(nonatomic,weak) UILabel* labTitle;

-(IBAction)btBackPress:(id)sender;

+(void)configNavBarController:(UINavigationController*)navBarController;
                               
@end
