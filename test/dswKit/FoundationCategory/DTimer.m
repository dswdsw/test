//
//  DTimer.m
//  test
//
//  Created by stephen on 15/3/26.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DTimer.h"



@implementation DTimer
{
    NSTimer *timer;
    timeBlock _block;
}

-(instancetype)init :(NSTimeInterval) time done:(timeBlock) block
{
    self=[super init];
    if (self) {
        timer=[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(time:) userInfo:nil repeats:YES];
        _block=block;
        
        [timer fire];
    }
    return self;
}

-(void)stop
{
    [timer invalidate];
}

-(void)time:(id)value
{
    _block(value);

}

@end
