//
//  UIView+quick.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (quick)

- (void)setRectOriginX:(CGFloat)x OriginY:(CGFloat)y width:(CGFloat)width widthRatioHeight:(CGFloat)ratio;

- (void)setRectOriginX:(CGFloat)x OriginY:(CGFloat)y height:(CGFloat)height heightRatioWidth:(CGFloat)ratio;

@end
