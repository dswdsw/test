//
//  NSString+AES.h
//  pwd
//
//  Created by stephen on 15/2/2.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

-(NSString *)AES256EncryptWithKey:(NSString *)key;

-(NSString *)AES256DecryptWithKey:(NSString *)key;

@end
