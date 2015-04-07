//
//  NSObject+quick.m
//  Car_ZJ
//
//  Created by stephen on 15/3/9.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import "NSObject+quick.h"
#import <objc/runtime.h>

@implementation NSObject (quick)
@dynamic toString;
@dynamic tagName;

static char *tagNameKey;
 

- (NSString *(^)())toString {
    return ^() {
               return [NSString stringWithFormat:@"%@", self];
    };
}

- (NSString *)getString {
    return [NSString stringWithFormat:@"%@", self];
}


-(NSString *)tagName
{
   return  objc_getAssociatedObject(self, &tagNameKey);
}
-(void)setTagName:(NSString *)tagName
{
    objc_setAssociatedObject(self, &tagNameKey, tagName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
