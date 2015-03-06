//
//  WLErrorTipViewController.m
//  test
//
//  Created by stephen on 15/3/4.
//  Copyright (c) 2015年 dsw. All rights reserved.
//

#import "WLErrorTipViewController.h"

@interface WLErrorTipViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation WLErrorTipViewController

+ (BOOL)hasCrash {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *path = [NSString stringWithFormat:@"%@/Documents/error.html", NSHomeDirectory()];

    return [fileManager fileExistsAtPath:path];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString    *path = [NSString stringWithFormat:@"%@/Documents/error.html", NSHomeDirectory()];
    NSURL       *url = [[NSURL alloc] initWithString:path];
    [self.web loadRequest:[NSURLRequest requestWithURL:url]];
}

- (IBAction)deleteLog:(id)sender {
    if ([WLErrorTipViewController hasCrash]) {
        NSFileManager   *fileManager = [NSFileManager defaultManager];
        NSString        *path = [NSString stringWithFormat:@"%@/Documents/error.html", NSHomeDirectory()];
        [fileManager removeItemAtPath:path error:nil];

        exit(0);
    }
}

@end
