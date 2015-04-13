//
//  CatchCrash.m
//  test
//
//  Created by stephen on 15/3/4.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "CatchCrash.h"
#import <UIKit/UIKit.h>
#import "WLErrorTipViewController.h"
#import "UIViewController+qiuck.h"

@implementation CatchCrash

+ (UIViewController *)openCatchCrash {
    WLErrorTipViewController *controller;

    if ([WLErrorTipViewController hasCrash]) {
        controller = [WLErrorTipViewController controllerFromXib];
    }

    return controller;
}

void uncaughtExceptionHandler(NSException *exception) {
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];

   // NSLog(@"%@", [stackArray[0] class]);

    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString        *name = [exception name];
    NSMutableString *exceptionInfo = [NSMutableString new];

    [exceptionInfo appendFormat:@"Exception reason: <br> %@   <br> ====================== <br>  Exception name: <br> %@  \n <br>=======================  \n <br> Exception stack: <br> ", name, reason];

    for (NSString *item in stackArray) {
        if ([item containsString:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]]) {
            [exceptionInfo appendFormat:@"%@", item];
            [exceptionInfo appendFormat:@"<br>"];
        }
    }
    
    NSLog(@"%@",[exceptionInfo stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]);

    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    // 保存到本地  —  当然你可以在下次启动的时候，上传这个log
    NSString *path = [NSString stringWithFormat:@"%@/Documents/error.html", NSHomeDirectory()];
    [exceptionInfo writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
