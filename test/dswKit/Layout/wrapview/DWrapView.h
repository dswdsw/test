//
//  DWrapView.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DLayoutBaseView.h"

/**
 *  流式布局
 */
@interface DWrapView : DLayoutBaseView

/**
 *  单元格x 偏移
 */
@property (nonatomic, assign) CGFloat xOffset;

/**
 *  单元格y 偏移
 */
@property (nonatomic, assign) CGFloat yOffset;

/**
 *  单元格高度
 */
@property (nonatomic, assign) CGFloat subHeight;

/**
 *  平均分成num 段 每段的宽度
 *
 *  @param num
 *
 *  @return
 */
- (CGFloat)getItemWidth:(NSInteger)num;

@end
