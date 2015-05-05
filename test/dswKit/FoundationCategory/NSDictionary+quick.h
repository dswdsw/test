//
//  NSDictionary+quick.h
//  Car_ZJ
//
//  Created by stephen on 15/3/18.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (quick)


/**
 *   获取 url参数格式字符串
 */
@property(nonatomic, readonly) NSString * (^toURLParaString)();


#pragma mark  数据转化
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;


+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData ;

-(NSString*)dictionaryToJsonString;

@end
