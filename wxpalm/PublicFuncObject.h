//
//  PublicFuncObject.h
//  wxpalm
//
//  Created by qiujian on 16/4/8.
//  Copyright © 2016年 jdfemqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalNavBarViewController.h"

@interface PublicFuncObject : NSObject

+(NormalNavBarViewController*)getNormalNavBar:(UIView*)viewParent;

@end
