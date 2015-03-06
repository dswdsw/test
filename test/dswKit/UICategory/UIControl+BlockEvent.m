//
//  UIControl+BlockEvent.m
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIControl+BlockEvent.h"
#import <objc/runtime.h>

@implementation UIControl (BlockEvent)

static char *clickEventKey;
static char *valueChangeEventKey;

- (void)click:(ClickBlock)buttonClickEvent {
    objc_setAssociatedObject(self, &clickEventKey, buttonClickEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);

    [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchDown];
}

- (void)clickAction:(id)value {
    ClickBlock blockClick = objc_getAssociatedObject(self, &clickEventKey);

    if (blockClick != nil) {
        blockClick(value);
    }
}

- (void)valueChange:(ClickBlock)buttonClickEvent {
    objc_setAssociatedObject(self, &valueChangeEventKey, buttonClickEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);

    [self addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChangeAction:(id)value {
    ClickBlock blockClick = objc_getAssociatedObject(self, &valueChangeEventKey);

    if (blockClick != nil) {
        blockClick(value);
    }
}

@end
