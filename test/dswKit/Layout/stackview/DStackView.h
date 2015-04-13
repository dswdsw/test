//
//  StackView.h
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLayoutBaseView.h"

/**
 *  堆栈布局
 */
@interface DStackView : DLayoutBaseView

- (void)addLineForHeight:(CGFloat)h;

- (void)addLineForHeight:(CGFloat)h color:(UIColor *)color;

/**
 *  距离父视图边距
 */
@property (nonatomic, assign) CGFloat offsetX;

@end
