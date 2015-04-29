//
//  UITextField+quick.h
//  Car_ZJ
//
//  Created by stephen on 15/3/10.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+BlockEvent.h"
typedef void (^ textFieldBlock)(UITextField *textField);

@interface UITextField (init)

+ (instancetype)textChange:(eventBlock)block fontSize:(CGFloat)size delegate:(id<UITextFieldDelegate>)delegate placehold:(NSString *)str defaultText:(NSString *)dt fontColor:(UIColor *)color;

+ (instancetype)textField:(textFieldBlock)block;



@end
