//
//  UIScrollView+quick.m
//  BCDD
//
//  Created by stephen on 15/4/9.
//  Copyright (c) 2015年 苏 丛林. All rights reserved.
//

#import "UIScrollView+quick.h"
#import "UIViewExt.h"

@implementation UIScrollView (quick)

-(void)autoContentSize
{
    CGFloat maxy=0;
    for (UIView *item in self.subviews) {
        if (item.height+item.top >maxy) {
            maxy=item.height+item.top;
        }
    }
    
    self.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, maxy);
}

@end
