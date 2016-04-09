//
//  UIBaseNavigationBar.m
//  wxpalm
//
//  Created by qiujian on 16/4/7.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "UIBaseNavigationBar.h"

@implementation UIBaseNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title {
    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [customNavigationBar addSubview:navigationBarBackgroundImageView];
    UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:title];
    [customNavigationBar pushNavigationItem:navigationTitle animated:NO];
    
    customNavigationBar.backgroundColor = [UIColor redColor];
    
    return customNavigationBar;
}

@end
