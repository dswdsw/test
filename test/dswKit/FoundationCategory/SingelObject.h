//
//  SingelObject.h
//  CDD
//
//  Created by stephen on 15/3/20.
//  Copyright (c) 2015年 苏 丛林. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  单例
 */
@interface SingelObject : NSObject

+ (instancetype )sharedInstance;

@end
