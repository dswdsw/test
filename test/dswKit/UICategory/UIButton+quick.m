//
//  UIButton+quick.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIButton+quick.h"

@implementation UIButton (quick)

- (void)setTitleForNormal:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleForHighlighted:(NSString *)title {
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setTitleForSelected:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
}

@end
