//
//  ShowNormalNavBarViewController.m
//  wxpalm
//
//  Created by qiujian on 16/4/7.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "ShowNormalNavBarViewController.h"
#import "PublicFuncObject.h"

@interface ShowNormalNavBarViewController ()
{
    NormalNavBarViewController* _viewNavBar;      // view上按钮响应决定控制器指针不能失效
}
@end

@implementation ShowNormalNavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载自定义NavBar
    _viewNavBar = [PublicFuncObject getNormalNavBar:self.view];
    [self.view addSubview:_viewNavBar.view];
    
    _viewNavBar.labTitle.text = self.title;
}

@end
