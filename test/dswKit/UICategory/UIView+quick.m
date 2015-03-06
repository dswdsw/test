//
//  UIView+quick.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIView+quick.h"

@implementation UIView (quick)

- (void)setRectOriginX:(CGFloat)x OriginY:(CGFloat)y width:(CGFloat)width widthRatioHeight:(CGFloat)ratio {
    self.frame= CGRectMake(x, y, width, width / ratio);
}

- (void)setRectOriginX:(CGFloat)x OriginY:(CGFloat)y height:(CGFloat)height heightRatioWidth:(CGFloat)ratio {
    self.frame= CGRectMake(x, y, height / ratio, height);
}

@end
