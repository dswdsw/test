//
//  UIView+quick.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlcok)();

@interface UIView (layout) 
 
+ (instancetype)viewNib;

/**
 *  清空子视图
 */
- (void)clearSubviews;


/**
 *  所有子视图
 *
 */
- (NSMutableArray *)allSubviews;

/**
 *  设置底部线条
 *
 *  @param color 颜色
 */
- (void)setBottomLine:(UIColor *)color;

/**
 *  当前视图的视图控制器
 */
@property (nonatomic, readonly) UIViewController *viewController;


-(void)floatLeftForView:(UIView *)view;

@end
