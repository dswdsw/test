//
//  FlowView.m
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DGridView.h"
#import "NSObject+quick.h"
#import <objc/runtime.h>
#import "UIViewExt.h"

//
#pragma mark - 网格
@interface UIView (Grid)

@property (nonatomic, strong) NSNumber  *row;
@property (nonatomic, strong) NSNumber  *columnNum;

@end

@implementation UIView (Grid)
@dynamic row;
@dynamic columnNum;

static char *rowKey;
static char *columnNumKey;

- (NSNumber *)row {
    return objc_getAssociatedObject(self, &rowKey);
}

- (void)setRow:(NSNumber *)row {
    objc_setAssociatedObject(self, &rowKey, row, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)columnNum {
    return objc_getAssociatedObject(self, &columnNumKey);
}

- (void)setColumnNum:(NSNumber *)columnNum {
    objc_setAssociatedObject(self, &columnNumKey, columnNum, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
//

#pragma mark - 行列
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

#pragma mark - grid

@implementation DGridView {
    // 配置
    NSInteger   column;
    NSInteger   rowHeight;
    // 标记
    NSInteger   currentRow;
    NSInteger   currentColumn;

    // 初始化次数
    NSInteger configNum;

    // 隐藏的行
    NSMutableArray *hideRowList;
    
    //
    NSMutableArray *lineList;
}

- (void)setColumn:(NSInteger)s height:(NSInteger)h {
    lineList=[ NSMutableArray new ];
    
    column = s;
    rowHeight = h;

    currentColumn = 0;
    currentRow = 0;

    configNum++;

    hideRowList = [NSMutableArray new];

    // 异常
    NSAssert(configNum == 1, @"setColumn只能调用一次");
}

-(NSInteger)rowHeight
{
    return rowHeight;
}

#pragma mark  add

- (void)addView:(UIView *)view {
    [self addView:view crossColumn:1];
}

- (void)addView:(UIView *)view crossColumn:(NSInteger)num {
    self.autoresizesSubviews = NO;

    // 异常
    NSAssert(column > 0, @"Column 列数不得为0");
    //
    CGRect  rect = self.frame;
    CGFloat columnWidth = (self.frame.size.width - 20) / column * num;

    rect = view.frame;

    // 隐藏一行
    CGFloat htemp = rowHeight;

    if (view.hidden) {
        htemp = 0;

        if (![hideRowList containsObject:@(currentRow)]) {
            [hideRowList addObject:@(currentRow)];
        }
    } else {
        htemp = rowHeight;
    }

    //

    rect.size = CGSizeMake(columnWidth, htemp);
    rect.origin = CGPointMake(currentColumn * ((self.frame.size.width - 20) / column) + 10, currentRow * rowHeight);
    view.frame = rect;
    view.row = @(currentRow);
    view.columnNum = @(num);
    [self addSubview:view];
    //
    currentColumn += num;

    if (currentColumn >= column) {
        currentRow += 1;
        currentColumn = 0;
    }

    //
    rect = self.frame;
    rect.size.height = (currentRow - hideRowList.count) * rowHeight;
    self.frame = rect;
    
    if (self.isShowLine) {
        [self ShowBorderLine];
    }
    else
    {
        [self hideBorderLine];
    }
    
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

#pragma mark  remove

- (void)removeRow:(NSInteger)row {
    for (UIView *item in self.subviews) {
        if ([item.row intValue] == row) {
            [item removeFromSuperview];
        }
    }

    [self updateView];
}

- (void)clearSubviews {
    [super clearSubviews];
    currentRow = 0;
    currentColumn = 0;
}

#pragma mark  show

- (void)showRow:(NSInteger)row {
    [hideRowList removeAllObjects];

    for (UIView *item in self.subviews) {
        if ([item.row intValue] == row) {
            item.hidden = NO;
        }
    }

    [self updateView];
}

- (void)hideRow:(NSInteger)row {
    [hideRowList removeAllObjects];

    for (UIView *item in self.subviews) {
        if ([item.row intValue] == row) {
            item.hidden = YES;
        }
    }

    [self updateView];
}

#pragma  mark  update
- (void)updateView {
    currentRow = 0;
    currentColumn = 0;

    for (UIView *item in self.subviews) {
        [self addView:item crossColumn:[item.columnNum intValue]];
    }

    [super updateView];
    

}


#pragma mark 线条
-(void)ShowBorderLine
{
    
    [self hideBorderLine];
    
    if (!self.lineColor) {
        self.lineColor=[UIColor grayColor];
    }
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = self.lineColor.CGColor;
    
    int count=(currentRow - hideRowList.count);
    
    if (count > 0) {
        for (int i = 0; i < count; i++) {
            CALayer *layer=[CALayer new];
            layer.frame=CGRectMake(0, i*rowHeight-0.25, self.width, 0.5);
            layer.backgroundColor=self.lineColor.CGColor;
            [self.layer addSublayer:layer];
            [lineList addObject:layer];
        }
    }

}

-(void)hideBorderLine
{
    
    self.layer.cornerRadius =0;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0;

    for (CALayer * item in lineList) {
        [item removeFromSuperlayer];
    }
}

@end
