//
//  CatchCrash.h
//  test
//
//  Created by stephen on 15/3/4.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CRASH NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler); UIViewController *controller = [CatchCrash openCatchCrash];                                              \
    if (controller) {                                                                                                                                                            \
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; [self.window makeKeyAndVisible]; self.window.rootViewController = controller; return YES; \
    }

@interface CatchCrash : NSObject

+ (UIViewController *)openCatchCrash;

void uncaughtExceptionHandler(NSException *exception);

@end
