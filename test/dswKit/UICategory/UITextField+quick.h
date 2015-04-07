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

@interface UITextField (quick) <UIPickerViewDataSource,UIPickerViewDelegate>

+ (instancetype)textChange:(ClickBlock)block fontSize:(CGFloat)size delegate:(id<UITextFieldDelegate>)delegate placehold:(NSString *)str defaultText:(NSString *)dt fontColor:(UIColor *)color;

+ (instancetype)textField:(textFieldBlock)block;

/**
 *  输入时间
 */
- (void)setInputTime;

/**
 *  选择输入
 *
 *  @param data 数据源
 */
-(void)setInputDropList:(NSArray *)data;

@end
