//
//  UIControl+BlockEvent.h
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ ClickBlock)(id value);

@interface UIControl (BlockEvent)

- (void)click:(ClickBlock)buttonClickEvent;

- (void)valueChange:(ClickBlock)buttonClickEvent;

-(void)editChange:(ClickBlock)buttonClickEvent;

@end
