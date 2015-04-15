//
//  UIView+quick.h
//  test
//
//  Created by stephen on 15/2/28.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlcok)();

@interface UIView (quick) <UIGestureRecognizerDelegate>
 
#pragma mark 手势

-(void)addTapGesture:(tapBlcok)block;


- (UIView *)findViewByTagName:(NSString *)tagname;
@end
