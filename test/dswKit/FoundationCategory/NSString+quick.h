//
//  NSString+quick.h
//  Car_ZJ
//
//  Created by stephen on 15/3/9.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^regBlock)(NSRange  range);
typedef NSString *(^mapStrBlock)(NSString  *value);

@interface NSString (quick)

#pragma mark  添加删除

/**
 *  拼接字符串（对象）
 */
@property(nonatomic, readonly) NSString *(^add)(NSObject *str);

/**
 *  删除指定字符串间的字符
 */
@property(nonatomic, readonly) NSString *(^removeRange)(NSString *startstr, NSString *endstr);

#pragma  mark 查找替换
/**
 *  正则表达式
 *
 *  @param reg     表达式
 *  @param replace 替换的字符
 *
 *  @return 结果
 */
- (NSString *)regex:(NSString *)reg replace:(NSString *)replace;

- (NSArray *)findstrWithregex:(NSString *)reg ;

-(void)findstrWithregex:(NSString *)reg done:(regBlock) block;

#pragma  mark 转化
-(NSString *)map:(mapStrBlock)Block;


#pragma mark 编码
/**
 *  NSString值为Unicode格式的字符串编码(如\u7E8C)转换成中文
 *  unicode编码以\u开头 (从服务器获得的数据一般是Unicode格式字符串)
 *
 *  @return
 */
- (NSString *)replaceUnicode;

@end
