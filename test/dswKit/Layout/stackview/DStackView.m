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

#pragma  mark - LINE
- (void)addLineForHeight:(CGFloat)h {
    [self addLineForHeight:h color:[UIColor clearColor]];
}

- (void)addLineForHeight:(CGFloat)h color:(UIColor *)color {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, h)];

    view.backgroundColor = color;
    CGFloat temp=self.offsetX;
    
    self.offsetX=0;
    [self addView:view];
    self.offsetX=temp;
}

#pragma  mark - ADD
- (void)addView:(UIView *)view {
    currentPoint.x=self.offsetX;
    
    self.autoresizesSubviews = NO;
    CGRect rect = view.frame;
    rect.origin = currentPoint;
    
    rect.size.width = self.frame.size.width-self.offsetX*2;
    view.frame = rect;

    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        [label sizeToFit];
    }

    [self addSubview:view];
    currentPoint.y += view.frame.size.height;

    rect = self.frame;
    // rect.size.width = view.frame.size.width;
    rect.size.height = currentPoint.y;
    self.frame = rect;
}

#pragma  mark - delete
- (void)deleteView:(UIView *)view {
    currentPoint = CGPointZero;
    [super deleteView:view];
}

- (void)clearSubviews {
    [super clearSubviews];
    currentPoint = CGPointZero;
}

#pragma  mark - update
- (void)updateView {
    currentPoint = CGPointZero;

    for (UIView *item in self.subviews) {
        [self addView:item];
    }

    [super updateView];
}

@end
