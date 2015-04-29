//
//  NSString+regularExpression.m
//  Car_ZJ
//
//  Created by stephen on 15/4/29.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "NSString+regularExpression.h"


NSString * const kRegEmail=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

@implementation NSString (regularExpression)

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
    
    if (rangeArr.count == 0) {
        return nil;
    }
    
    return rangeArr;
}

- (void)findstrWithregex:(NSString *)reg done:(regBlock)block {
    NSArray *array = [self findstrWithregex:reg];
    
    for (NSValue *item in array) {
        block(item.rangeValue);
    }
}

@end
