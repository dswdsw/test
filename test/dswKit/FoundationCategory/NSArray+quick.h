//
//  NSArray+quick.h
//  Car_ZJ
//
//  Created by stephen on 15/3/17.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^mapBlock)(id obj);

typedef  BOOL (^filterBlock) (id evaluatedObject, NSDictionary *bindings);

@interface NSArray (quick)

/**
 *  获取 子元素（字典类型） 指定键 的值 列表
 *
 *  @param key 键
 *
 *  @return  新列表
 */
-(NSArray *) getArrayFormDictionaryList:(NSString *)key;

/**
 *  自定条件转换成新数组
 *
 *  @param block 条件
 *
 *  @return 新列表
 */
-(NSArray *)map :(mapBlock)block ;

/**
 *  过滤
 *
 *  @param block
 *
 *  @return 
 */
-(NSArray *)filtered: (filterBlock) block;

@end
