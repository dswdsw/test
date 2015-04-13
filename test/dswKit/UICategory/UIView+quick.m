//
//  UIView+quick.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIView+quick.h"
#import "UIViewExt.h"
#import "NSObject+quick.h"
#import <objc/runtime.h>

@implementation UIView (quick)

@dynamic viewController;

+ (instancetype)viewNib {
    UIView  *result = nil;
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
        owner:nil options:nil];

    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            result = anObject;
            break;
        }
    }

    return result;
}

- (void)clearSubviews {
    for (UIView *item in self.subviews) {
        [item removeFromSuperview];
    }
}

- (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableArray *)outArray {
    [outArray addObject:aView];
    for (UIView *view in [aView subviews]) {
        [self dumpView:view atIndent:indent + 1 into:outArray];
    }
}

- (NSMutableArray *)allSubviews {
    NSMutableArray *outViews=[NSMutableArray new ];
    [self dumpView:self atIndent:0 into:outViews];
    return outViews;
}


- (void)setBottomLine:(UIColor *)color;
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    view.backgroundColor = color;
    view.alpha = 0.3;
    [self addSubview:view];
}

- (UIViewController *)viewController {
    /// Finds the view's view controller.
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;

    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }

    // If the view controller isn't found, return nil.
    return nil;
}

- (UIView *)findViewByTagName:(NSString *)tagname {
    for (UIView *item in self.subviews) {
        if ([item.tagName isEqualToString:tagname]) {
            return item;
        }
    }

    return nil;
}

#pragma mark 手势

static char *tapKey;

- (void)addTapGesture:(tapBlcok)block {
    objc_setAssociatedObject(self, &tapKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelector:)];
    self.userInteractionEnabled = YES;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tapSelector:(id)value {
    tapBlcok block = objc_getAssociatedObject(self, &tapKey);

    block(value);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
