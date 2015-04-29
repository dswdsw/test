//
//  NSString+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/9.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "NSString+quick.h"

@implementation NSString (quick)
@dynamic add;
@dynamic  removeRange;

- (NSString *(^)(NSObject *))add {
    return ^(NSObject *str) {
               if (!str) {
                   str = @"";
                   NSLog(@"================参数为nil==================");
               }

               return [self stringByAppendingFormat:@"%@", str];
    };
}

- (NSString *(^)(NSString *, NSString *))removeRange {
    return ^(NSString *startstr, NSString *endstr)
           {

               NSString *regstr=[NSString stringWithFormat:@"['%@'].*['%@']",startstr,endstr];
               
               return [self regex:regstr replace:@""];
           };
}


- (NSString *)map:(mapStrBlock)Block {
    NSString *str = Block(self);

    return str;
}

- (NSString *)replaceUnicode {
    NSString    *unicodeStr = self;
    NSString    *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString    *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString    *tempStr3 = [[@"\""stringByAppendingString : tempStr2] stringByAppendingString:@"\""];
    NSData      *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString    *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
        mutabilityOption:NSPropertyListImmutable
        format          :NULL
        errorDescription:NULL];

    //    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

@end
