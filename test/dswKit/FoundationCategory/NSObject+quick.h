//
//  NSObject+quick.h
//  Car_ZJ
//
//  Created by stephen on 15/3/9.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (quick)


/**
 *  转成字符串
 */
@property(nonatomic, readonly) NSString *(^toString)();

-(NSString *)getString;

@property(nonatomic ,strong) NSString *tagName;

@end
