//
//  FlowView.h
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLayoutBaseView.h"


/**
 *  网格布局
 */
@interface DGridView : DLayoutBaseView

#pragma mark  show line

@property (nonatomic, strong)  UIColor *lineColor;

@property (nonatomic, assign) BOOL isShowLine;

#pragma mark  init

@property (nonatomic, readonly) NSInteger rowHeight;

- (void)setColumn:(NSInteger)s height:(NSInteger)h;

#pragma mark  add view

- (void)addView:(UIView *)view crossColumn:(NSInteger)num;

#pragma mark  delete view

- (void)removeRow:(NSInteger)row;

#pragma mark  show hide

- (void)showRow:(NSInteger)row;

- (void)hideRow:(NSInteger)row;

@end
