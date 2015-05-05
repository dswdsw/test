//
//  NSDictionary+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/18.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "NSDictionary+quick.h"
#import "NSString+quick.h"
#import "NSObject+quick.h"

@implementation NSDictionary (quick)

@dynamic toURLParaString;

- (NSString *(^)())toURLParaString {
    return ^{
               NSMutableString *str = [NSMutableString new];

               for (NSString *keys in self.allKeys) {
                   if (str.length > 0) {
                       [str appendString:@"&"];
                   }

                   [str appendString:keys];
                   [str appendString:@"="];
                   [str appendString:[self[keys] getString ] ];
               }

               return str;
    };
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData
{
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return object;
}

-(NSString*)dictionaryToJsonString
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
