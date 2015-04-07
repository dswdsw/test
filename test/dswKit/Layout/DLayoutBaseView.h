//
//  SpecialBaseView.h
//  test
//
//  Created by stephen on 15/2/12.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+quick.h"

@interface DLayoutBaseView : UIView
{
    NSException *error;
}

- (instancetype)initWidth:(CGFloat)width;

- (void)setOrigin:(CGPoint)point;

@property (nonatomic , readonly ) void (^setPositions)(CGFloat x, CGFloat y);


- (void)addView:(UIView *)view;

- (void)deleteView:(UIView *)view;

-(void)updateView;

@end
