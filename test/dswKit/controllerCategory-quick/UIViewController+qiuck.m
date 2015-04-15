//
//  UIViewController+qiuck.m
//  test
//
//  Created by stephen on 15/3/5.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "UIViewController+qiuck.h"
#import "NSString+quick.h"

@implementation UIViewController (qiuck)

+ (instancetype)controllerFromXib {
    return [[self alloc]initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)storyboard:(NSString *)name id:(NSString *)key {
    UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:name bundle:nil];

    return [stroryboard instantiateViewControllerWithIdentifier:key];
}

- (void)firstLuanch:(firstLuanchBlock)block key:(NSString *)keys;
{
    
   NSString *VersionKey=  [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    NSString *key = NSStringFromClass([self class]).add(@"_").add(keys).add(@"_DSWKey").add(VersionKey);
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        block();
    }
}

-(void)firstLuanch :(firstLuanchBlock) block
{
    [self firstLuanch:block key:@"default"];
}

@end
