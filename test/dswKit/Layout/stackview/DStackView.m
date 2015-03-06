//
//  StackView.m
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DStackView.h"

@implementation DStackView
{
    CGPoint currentPoint;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        currentPoint = CGPointZero;
    }

    return self;
}

- (void)addView:(UIView *)view {
    if ([self.subviews containsObject:view]) {
        return;
    }

    CGRect rect = view.frame;
    rect.origin = currentPoint;
    view.frame = rect;
    [self addSubview:view];
    currentPoint.y += view.frame.size.height;

    rect = self.frame;
    // rect.size.width = view.frame.size.width;
    rect.size.height = currentPoint.y;
    self.frame = rect;
}

- (void)deleteView:(UIView *)view {
    currentPoint = CGPointZero;
    [super deleteView:view];
}

@end
