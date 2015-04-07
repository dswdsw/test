//
//  LPLabel.h
//  label上画横线
//
//  Created by Li Pan on 14-6-30.
//  Copyright (c) 2014年 Pan Li. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE  @interface LPLabel : UILabel

@property (assign, nonatomic) IBInspectable BOOL strikeThroughEnabled; // 是否画线

@property (strong, nonatomic) IBInspectable UIColor *strikeThroughColor; // 画线颜色

@end
