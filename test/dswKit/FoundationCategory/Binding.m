//
//  Binding.m
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "Binding.h"

@implementation BindingBox

@end


@implementation Binding
{
    NSMutableArray *bindingList;
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        bindingList =[NSMutableArray new];
        
           
    }
    return self;
}

-(void)bindKeyPath:(NSString *)keyPath  object:(id)obj block:(bindingBlock)block
{
    BindingBox *bb=[BindingBox new];
    bb.key=keyPath;
    bb.obj=obj;
    bb.blcok=block;
    [bindingList addObject:bb];
    
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionInitial context:nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    for (BindingBox *item in bindingList) {
        if ([keyPath isEqualToString:item.key]) {
            item.blcok();
        }
    }
}

-(void)dealloc
{
    for (BindingBox *item in bindingList) {
        [item.obj removeObserver:self];
    }
}



@end
