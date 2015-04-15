//
//  UITextField+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/10.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "UITextField+quick.h"
#import <objc/runtime.h>
#import "NSObject+quick.h"

@implementation UITextField (quick)

//
+ (instancetype)textChange:(eventBlock)block fontSize:(CGFloat)size delegate:(id<UITextFieldDelegate>)delegate placehold:(NSString *)str defaultText:(NSString *)dt fontColor:(UIColor *)color {
    UITextField *text = [UITextField new];

    [text editChange:block];
    text.font = [UIFont systemFontOfSize:size];
    text.delegate = delegate;
    text.placeholder = str;
    text.text = dt;

    if (!color) {
        color = [UIColor blackColor];
    }

    text.textColor = color;
    return text;
}

//
+ (instancetype)textField:(textFieldBlock)block {
    UITextField *text = [UITextField  new];

    block(text);
    return text;
}



@end
