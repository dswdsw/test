//
//  NSArray+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/17.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "NSArray+quick.h"

@implementation NSArray (quick)

- (NSArray *)getArrayFormDictionaryList:(NSString *)key {
    NSMutableArray *array = [NSMutableArray new];

    if (!self) {
        return nil;
    }

    if (self.count == 0) {
        return nil;
    }

    for (NSDictionary *dic in self) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [array addObject:dic[key]];
        }
    }

    return array;
}

- (NSArray *)map:(mapBlock)block {
    
    NSMutableArray *array=[NSMutableArray array];
    
    for (int i=0; i< self.count ; i++) {
        [array addObject :block(self[i]) ];
    }
    return array;
}

@end
