//
//  IndexArray.m
//  MyImagePicker
//
//  Created by stephen on 15-2-6.
//
//

#import "IndexArray.h"

@implementation NSMutableArray (IndexArray)

- (void)addNSInteger:(NSInteger)item {
    [self addObject:[NSNumber numberWithInteger:item]];
}

- (void)removeNSInteger:(NSInteger)item {
    [self removeObject:[NSNumber numberWithInteger:item]];
}

- (BOOL)containsNSInteger:(NSInteger)item {
    return [self containsObject:[NSNumber numberWithInteger:item]];
}

@end
