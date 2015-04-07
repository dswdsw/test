//
//  UILabel+quick.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UILabel+quick.h"



@implementation UILabel (quick)

+ (instancetype)label:(NSString *)text fontsize:(CGFloat)size fontColor:(UIColor *)color {
    UILabel *label = [UILabel  new];

    label.text = text;
    label.font = [UIFont systemFontOfSize:size];

    if (!color) {
        color = [UIColor blackColor];
    }

    label.textColor = color;
    return label;
}

+( instancetype)label:(lableBlock)block
{
    UILabel *label = [UILabel  new];
    block(label);
    return label;
}

@end
