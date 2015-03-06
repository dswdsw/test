//
//  FlowView.h
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLayoutBaseView.h"

#define DCrossColumnMake(c, n) [[DCrossColumn alloc] initColumn : c crossColumn : n]

@interface DCrossColumn : NSObject

- (instancetype)initColumn:(NSInteger)column crossColumn:(NSInteger)num;

@property (nonatomic, assign) NSInteger column;

@property (nonatomic, assign) NSInteger crossNum;

@end

/**
 *  网格布局
 */
@interface DGridView : DLayoutBaseView

@property (nonatomic, strong) NSArray *crossArray;

- (void)setColumn:(NSInteger)s height:(NSInteger)h;

- (void)addView:(UIView *)view crossColumn:(NSInteger)num;

- (void)addViewArray:(NSArray *)array;

- (void)addViewFromXib:(NSString *)xibname point:(CGPoint)point;

@end
