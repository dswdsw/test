//
//  SpecialBaseView.m
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DLayoutBaseView.h"

@implementation DLayoutBaseView

- (instancetype)init {
    self = [super init];

    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    }

    return self;
}

- (instancetype)initWidth:(CGFloat)width {
    self = [self init];

    if (self) {
        self.frame = CGRectMake(0, 0, width, 0);
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)addView:(UIView *)view {}

- (void)deleteView:(UIView *)view {
    [view removeFromSuperview];
    NSArray *views = self.subviews;

    for (UIView *item in self.subviews) {
        [item removeFromSuperview];
    }

    for (UIView *item in views) {
        [self addView:item];
    }
}

- (void)setOrigin:(CGPoint)point {
    CGRect rect = self.frame;

    rect.origin = point;
    self.frame = rect;
}

@end