//
//  IndexArray.h
//  MyImagePicker
//
//  Created by stephen on 15-2-6.
//
//

#import <Foundation/Foundation.h>

@interface  NSMutableArray (IndexArray)

- (void)addNSInteger:(NSInteger)item;

- (void)removeNSInteger:(NSInteger)item;

- (BOOL)containsNSInteger:(NSInteger)item;

@end
