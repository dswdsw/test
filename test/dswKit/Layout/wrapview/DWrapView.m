//
//  DWrapView.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DWrapView.h"


@implementation DWrapView
{
    CGRect currectFrame;
}

- (void)addView:(UIView *)view {
    self.autoresizesSubviews = NO;

    if (self.subHeight == 0) {
        self.subHeight = 44;
    }

    CGFloat superWidth = self.frame.size.width;
    CGFloat viewWidth = view.frame.size.width;
    CGFloat newOriginX = currectFrame.origin.x + currectFrame.size.width;
    // 异常
    NSAssert(viewWidth < superWidth, @"子视图宽度大于父视图");
    CGRect rect = view.frame;

    if (newOriginX + viewWidth + self.xOffset < superWidth) {
        // 插入当前行
        rect.origin.x = newOriginX + self.xOffset;
        rect.origin.y = currectFrame.origin.y;
    } else {
        // 插入新行
        rect.origin.x = self.xOffset;
        rect.origin.y = currectFrame.origin.y + currectFrame.size.height + self.yOffset;
    }

    rect.size.height = self.subHeight;
    view.frame = rect;
    [self addSubview:view];
    currectFrame = rect;

    rect = self.frame;
    rect.size.height = view.frame.origin.y + view.frame.size.height;
    self.frame = rect;
}

- (void)deleteView:(UIView *)view {
    currectFrame = CGRectZero;
    [super deleteView:view];
}

- (void)clearSubviews {
    [super clearSubviews];
    currectFrame = CGRectZero;
}

- (void)updateView {
    currectFrame = CGRectZero;
    for (UIView *item in self.subviews) {
        [self addView:item];
    }
    [super updateView];
}


-(CGFloat)getItemWidth :(NSInteger) num
{
    return (self.width-(self.xOffset*num+1)-1)/num;
}

@end
