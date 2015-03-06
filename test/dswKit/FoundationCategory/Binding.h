//
//  Binding.h
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ bindingBlock)();

@interface BindingBox : NSObject

@property (nonatomic , strong ) id obj;
@property (nonatomic , strong ) NSString *key;
@property (nonatomic , strong ) bindingBlock blcok;

@end

@interface Binding : NSObject

-(void)bindKeyPath:(NSString *)keyPath  object:(id)obj block:(bindingBlock)block;

@end
