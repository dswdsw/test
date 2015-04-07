//
//  DTimer.h
//  test
//
//  Created by stephen on 15/3/26.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^timeBlock)(id vlaue);

@interface DTimer : NSObject
-(instancetype)init :(NSTimeInterval) time done:(timeBlock) block;
-(void)stop;
@end
