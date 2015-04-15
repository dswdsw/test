//
//  FlowView.m
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DGridView.h"
#import <objc/runtime.h>
#import "NSObject+quick.h"

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

//处理label
@interface UILabel (autoHeight)

-(void)autoHeight;

@end

@implementation UILabel (autoHeight)

- (void)autoHeight {
    CGSize size = CGSizeMake(self.frame.size.width, 2000);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        CGSize labelsize = [self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        self.height = labelsize.height;
        self.numberOfLines = 0;
    } else {
        CGRect labelRect = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName] context:nil];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelRect.size.width, labelRect.size.height);
        self.lineBreakMode = NSLineBreakByCharWrapping;
        self.numberOfLines = 0;
    }
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

    NSMutableDictionary *dicRowHeight;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self updateView];
}

- (void)setColumn:(NSInteger)s height:(NSInteger)h {
    lineList = [NSMutableArray new];
    self.lineColor = [UIColor colorWithWhite:0.4 alpha:0.5];

    dicRowHeight = [NSMutableDictionary new];

    self.isShowLine = YES;
    column = s;
    rowHeight = h;

    currentColumn = 0;
    currentRow = 0;

    configNum++;

    hideRowList = [NSMutableArray new];

    // 异常
    NSAssert(configNum == 1, @"setColumn只能调用一次");
}

- (NSInteger)rowHeight {
    return rowHeight;
}

#pragma mark size
- (void)recordHeight:(UIView *)view {
    NSString    *key = view.row.toString(); // 行
    CGFloat     height = view.height;

    if (dicRowHeight[key]) {
        if ([dicRowHeight[key] floatValue] < height) {
            dicRowHeight[key] = @(height);
        }
    } else {
        dicRowHeight[key] = @(height);
    }
}

- (CGFloat)getRowHeight:(NSInteger)row {
    NSString *key = @(row).toString(); // 行

    if (dicRowHeight[key]) {
        return [dicRowHeight[key] floatValue];
    }

    return rowHeight;
}

- (CGFloat)getAllHeight {
    CGFloat sum = 0;

    for (int i = 0; i < currentRow; i++) {
        sum += [self getRowHeight:i];
    }

    return sum;
}

- (CGFloat)getHeightToRow:(NSInteger)row {
    CGFloat sum = 0;

    for (int i = 0; i <= row; i++) {
        sum += [self getRowHeight:i];
    }

    return sum;
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
    CGFloat columnWidth = (self.frame.size.width - column*2) / column * num;

    rect = view.frame;

    // 隐藏一行
    CGFloat htemp = [self getRowHeight:currentRow];

    if (view.hidden) {
        htemp = 0;

        if (![hideRowList containsObject:@(currentRow)]) {
            [hideRowList addObject:@(currentRow)];
        }
    }

    //
    rect.size = CGSizeMake(columnWidth, htemp);
    rect.origin = CGPointMake(currentColumn * ((self.frame.size.width - 20) / column) + 10, [self getAllHeight]);
    view.frame = rect;
    view.row = @(currentRow);
    view.columnNum = @(num);

    [self recordHeight:view];

    if ([view isKindOfClass:[UITextField class]]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            ((UITextField *)view).contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }

    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *tlb = (UILabel *)view;
        [tlb autoHeight];

        if (tlb.height < htemp) {
            tlb.height = htemp;
        }

        [self recordHeight:view];
    }

    [self addSubview:view];

    //
    currentColumn += num;

    if (currentColumn >= column) {
        currentRow += 1;
        currentColumn = 0;
    }

    //
    rect = self.frame;

    rect.size.height = [self getAllHeight];

    for (NSNumber *item in hideRowList) {
        rect.size.height -= [self getRowHeight:[item integerValue]];
    }

    self.frame = rect;

    [self setBorder];
}

- (void)deleteView:(UIView *)view {
    currentRow = 0;
    currentColumn = 0;
    [super deleteView:view];
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

    for (CALayer *item in lineList) {
        [item removeFromSuperlayer];
    }

    [lineList removeAllObjects];

    for (UIView *item in self.subviews) {
        [self addView:item crossColumn:[item.columnNum intValue]];
    }

    [super updateView];
}

- (void)setBorder {
    // border
    if (dicRowHeight.allKeys.count > 1) {
        if (self.isShowLine) {
            self.layer.cornerRadius = 4;
            self.layer.masksToBounds = YES;
            self.layer.borderWidth = 0.5;
            self.layer.borderColor = self.lineColor.CGColor;

            for (CALayer *item in lineList) {
                [item removeFromSuperlayer];
            }

            [lineList removeAllObjects];

            for (int i = 0; i < dicRowHeight.allKeys.count - 1 - hideRowList.count; i++) {
                CALayer *layer = [CALayer new];
                layer.frame = CGRectMake(0, [self getHeightToRow:i] - 0.5, self.width, 0.5);
                layer.backgroundColor = self.lineColor.CGColor;
                [self.layer addSublayer:layer];
                [lineList addObject:layer];
            }
        } else {
            self.layer.cornerRadius = 0;
            self.layer.masksToBounds = YES;
            self.layer.borderWidth = 0;
            self.layer.borderColor = self.lineColor.CGColor;

            for (CALayer *item in lineList) {
                [item removeFromSuperlayer];
            }

            [lineList removeAllObjects];
        }
    }
}

@end
