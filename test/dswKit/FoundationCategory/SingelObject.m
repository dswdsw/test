//
//  SingelObject.m
//  CDD
//
//  Created by stephen on 15/3/20.
//  Copyright (c) 2015年 苏 丛林. All rights reserved.
//

#import "SingelObject.h"

@implementation SingelObject


+ (instancetype )sharedInstance
{
    static SingelObject *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
@end
