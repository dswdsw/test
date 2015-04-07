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

@property (nonatomic, strong) id            obj;
@property (nonatomic, strong) NSString      *key;
@property (nonatomic, strong) bindingBlock  blcok;

@end

/**
 *  注意:不要作为局部变量
 */
@interface DBinding : NSObject

/**
 *  属性变化绑定
 *
 *  @param keyPath 对象的属性
 *  @param obj     要被观察的对象
 *  @param block   属性变化后
 */
- (void)bindKeyPath:(NSString *)keyPath object:(id)obj block:(bindingBlock)block;

/**
 *  属性变化绑定
 */
@property(nonatomic, readonly) void (^bind) (NSString *keyPath, id obj, bindingBlock block);

@end
