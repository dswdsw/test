//
//  UINavigationController+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/27.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "UINavigationController+quick.h"

@implementation UINavigationController (quick)


-(id)getPreviousController
{
    if (self.viewControllers.count>=2) {
         return   self.viewControllers[self.viewControllers.count - 2];
    }
    return nil;
}
@end
