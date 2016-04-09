//
//  PublicFuncObject.m
//  wxpalm
//
//  Created by qiujian on 16/4/8.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import "PublicFuncObject.h"

@implementation PublicFuncObject

+(NormalNavBarViewController*)getNormalNavBar:(UIView*)viewParent
{
    // 加载自定义NavBar
    UIStoryboard* psStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NormalNavBarViewController* navBarcontroller = [psStoryboard instantiateViewControllerWithIdentifier:@"NavBarViewController"];
    
    CGRect rc = viewParent.frame;
    
    [navBarcontroller.view setFrame:CGRectMake(0, 20, rc.size.width, 44)];
    
    return navBarcontroller;
}

@end
