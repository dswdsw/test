//
//  Binding.m
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "DBinding.h"
#import <objc/runtime.h>
#import "NSString+quick.h"

@implementation BindingBox

@end

@implementation DBinding
{
    NSMutableArray *bindingList;
}
@dynamic bind;

- (instancetype)init {
    self = [super init];

    if (self) {
        bindingList = [NSMutableArray new];
    }

    return self;
}

- (void (^)(NSString *keyPath, id obj, bindingBlock block))bind {
    return ^(NSString *keyPath, id obj, bindingBlock block)
           {
               return [self bindKeyPath:keyPath object:self block:block];
           };
}

- (void)bindKeyPath:(NSString *)keyPath object:(id)obj block:(bindingBlock)block {
   // NSAssert([obj containsValueForKey:keyPath], NSStringFromClass([obj class]).add(keyPath).add(@"不存在"));
    BindingBox *bb = [BindingBox new];
    bb.key = keyPath;
    bb.obj = obj;
    bb.blcok = block;
    [bindingList addObject:bb];

    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    for (BindingBox *item in bindingList) {
        if ([keyPath isEqualToString:item.key]) {
            item.blcok();
        }
    }
}

- (void)dealloc {
    NSLog(@"被销毁");
    for (BindingBox *item in bindingList) {
        [item.obj removeObserver:self];
    }
}

@end
