//
//  UIViewController+qiuck.m
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIViewController+init.h"
#import "NSString+quick.h"

@implementation UIViewController (qiuck)

+ (instancetype)controllerFromXib {
    return [[self alloc]initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)storyboard:(NSString *)name id:(NSString *)key {
    UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:name bundle:nil];

    return [stroryboard instantiateViewControllerWithIdentifier:key];
}

@end
