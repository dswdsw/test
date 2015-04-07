//
//  UILabel+quick.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef void  (^lableBlock)(UILabel *label);

@interface UILabel (quick)

+ (instancetype)label:(NSString *)text fontsize:(CGFloat)size fontColor:(UIColor *)color;

+( instancetype)label:(lableBlock)block;

@end
