//
//  UILabel+quick.m
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UILabel+quick.h"
#import "UIViewExt.h"
#import "NSObject+quick.h"

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

+ (instancetype)label:(lableBlock)block {
    UILabel *label = [UILabel  new];

    block(label);
    return label;
}

- (void)addRightImg:(NSString *)imgName {
    CALayer *layer = [[CALayer alloc]init];

    layer.tagName = @"right";
    layer.frame = CGRectMake(self.width, 0, self.height, self.height);
    layer.contents = (id) [UIImage imageNamed : imgName].CGImage;
    [self.layer addSublayer:layer];

    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)addLeftImg:(NSString *)imgName {
    CALayer *layer = [[CALayer alloc]init];

    layer.tagName = @"left";
    layer.frame = CGRectMake(-self.height, 0, self.height, self.height);
    layer.contents = (id) [UIImage imageNamed : imgName].CGImage;
    [self.layer addSublayer:layer];

    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [self sizeToFit];

        for (CALayer *item in self.layer.sublayers) {
            if ([item.tagName isEqualToString:@"right"]) {
                item.frame = CGRectMake(self.width, 0, self.height, self.height);
            } else if ([item.tagName isEqualToString:@"left"]) {
                item.frame = CGRectMake(-self.height, 0, self.height, self.height);
            }
        }
    }
}

// -(void)dealloc
// {
//    [self removeObserver:self forKeyPath:@"text"];
// }

@end
