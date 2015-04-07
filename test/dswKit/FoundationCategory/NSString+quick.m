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
               NSRange rg1 = [self rangeOfString:startstr];

               NSRange rg2 = [self rangeOfString:endstr];

               if (rg1.location==NSNotFound || rg2.location==NSNotFound) {
                   return self;
               }
               NSAssert(rg1.location < rg2.location, @"end 位置大于 start 位置");

               NSRange range = NSMakeRange(rg1.location, labs(rg2.location + rg2.length - rg1.location));

               return [self stringByReplacingCharactersInRange:range withString:@""];
           };
}

- (NSString *)regex:(NSString *)reg replace:(NSString *)replace {
    NSString            *searchText = self;
    NSError             *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionCaseInsensitive error:&error];

    while (true) {
        NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];

        if (result.range.length > 0) {
            searchText = [searchText stringByReplacingCharactersInRange:result.range withString:replace];
        } else {
            break;
        }
    }

    return searchText;
}

- (NSArray *)findstrWithregex:(NSString *)matchRegex  {
    NSString            *str = self;
    NSError             *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:matchRegex
                                                    options                     :NSRegularExpressionCaseInsensitive
                                                    error                       :&error];
    NSArray *match = [reg matchesInString:str
        options :NSMatchingReportCompletion
        range   :NSMakeRange(0, [str length])];

    NSMutableArray *rangeArr = [NSMutableArray array];

    // 取得所有的NSRange对象
    if (match.count != 0) {
        for (NSTextCheckingResult *matc in match) {
            NSRange range = [matc range];
            NSValue *value = [NSValue valueWithRange:range];
            [rangeArr addObject:value];
        }
    }

    if (rangeArr.count==0) {
        return nil;
    }
    return rangeArr;
}

-(void)findstrWithregex:(NSString *)reg done:(regBlock) block
{
   NSArray *array=  [self findstrWithregex:reg];
    for (NSValue * item in array) {
        block(item.rangeValue);
    }
}

-(NSString *)map:(mapStrBlock)Block
{
    NSString *str= Block(self);
   return  str;
    
}



- (NSString *)replaceUnicode
{
    NSString *unicodeStr=self;
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
//    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


@end
