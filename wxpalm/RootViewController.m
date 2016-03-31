//
//  RootViewController.m
//  wxpalm
//
//  Created by qiujian on 16/3/20.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 背景透明
    UINavigationBar* navBar = self.navigationController.navigationBar;
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        
        [navBar setBackgroundImage:[UIImage imageNamed:@"Home.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:TRUE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
