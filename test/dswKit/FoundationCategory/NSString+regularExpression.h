//
//  NSString+regularExpression.h
//  Car_ZJ
//
//  Created by stephen on 15/4/29.
//  Copyright (c) 2015年 网兰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ regBlock)(NSRange range);

extern NSString *const kRegEmail;

@interface NSString (regularExpression)

/**
 *  正则表达式
 *
 *  @param reg     表达式
 *  @param replace 替换的字符
 *
 *  @return 结果
 */
- (NSString *)regex:(NSString *)reg replace:(NSString *)replace;

- (NSArray *)findstrWithregex:(NSString *)reg;

- (void)findstrWithregex:(NSString *)reg done:(regBlock)block;

@end
