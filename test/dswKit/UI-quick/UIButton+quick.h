//
//  UIButton+quick.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^buttonBlock)(UIButton *button);

@interface UIButton (quick)

- (void)setTitleForNormal:(NSString *)title;

- (void)setTitleForHighlighted:(NSString *)title;

- (void)setTitleForSelected:(NSString *)title;

+( instancetype)button:(buttonBlock)block;

@end
