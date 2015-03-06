//
//  FlowView.m
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DGridView.h"

@implementation DCrossColumn

- (instancetype)initColumn:(NSInteger)column crossColumn:(NSInteger)num {
    self = [super init];

    if (self) {
        self.column = column;
        self.crossNum = num;
    }

    return self;
}

@end

@implementation DGridView {
    // 配置
    NSInteger   column;
    NSInteger   rowHeight;
    // 标记
    NSInteger   currentRow;
    NSInteger   currentColumn;

    NSInteger configNum;
}

- (void)setColumn:(NSInteger)s height:(NSInteger)h {
    column = s;
    rowHeight = h;

    currentColumn = 0;
    currentRow = 0;

    configNum++;

    // 异常
    NSAssert(configNum == 1, @"setColumn只能调用一次");
}

- (void)addView:(UIView *)view {
    [self addView:view crossColumn:1];
}

- (void)addView:(UIView *)view crossColumn:(NSInteger)num {
    if ([self.subviews containsObject:view]) {
        return;
    }

    // 异常
    NSAssert(column > 0, @"Column 列数不得为0");
    //
    CGRect  rect = self.frame;
    CGFloat columnWidth = self.frame.size.width / column * num;

    rect = view.frame;
    rect.size = CGSizeMake(columnWidth, rowHeight);
    rect.origin = CGPointMake(currentColumn * (self.frame.size.width / column), currentRow * rowHeight);
    view.frame = rect;

    [self addSubview:view];
    //
    currentColumn += num;

    if (currentColumn >= column) {
        currentRow += 1;
        currentColumn = 0;
    }

    //
    rect = self.frame;
    rect.size.height = currentRow * rowHeight;
    self.frame = rect;
}

- (void)addViewArray:(NSArray *)array {
    for (UIView *item in array) {
        NSInteger crossColumn = 1;

        for (DCrossColumn *item in self.crossArray) {
            if (currentColumn == item.column) {
                crossColumn = item.crossNum;
                break;
            }
        }

        [self addView:item crossColumn:crossColumn];
    }
}

- (void)deleteView:(UIView *)view {
    currentRow = 0;
    currentColumn = 0;
    [super deleteView:view];
}

- (void)addViewFromXib:(NSString *)xibname point:(CGPoint)point {
    NSMutableArray *array = [NSMutableArray new];

    for (int i = point.x; i <= point.y; i++) {
        NSArray *xibs = [[NSBundle mainBundle]loadNibNamed:xibname owner:self options:nil];
        [array addObject:xibs[i]];
    }

    [self addViewArray:array];
}

@end
