//
//  RtspDemoViewController.m
//  RtspDemo
//
//  Created by cj on 12-6-27.
//  Copyright 2012 kaiyu. All rights reserved.
//

#import "RtspDemoViewController.h"
#import "testClient.h"

static RtspDemoViewController *_rtspDemoViewController;

static int rtspCallBack(void *buff, int len, int w, int h) {
    // NSLog(@"rtspCallBack len: %d", len);
    [_rtspDemoViewController onRtspData:(Byte *)buff
    len     :len
    width   :w
    height  :h];

    return 0;
}

@implementation RtspDemoViewController

@synthesize imageView = _imageView;
@synthesize activityIndicatorView = _activityIndicatorView;

#pragma  mark private methods


- (UIImage *)imageWithRGBData:(Byte *)pData width:(unsigned)w height:(unsigned)h {
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(pData, w, h, 8,
            w * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);

    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    // Create an image object from the Quartz image
    UIImageOrientation imageOrientation = UIImageOrientationUp;

    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:(CGFloat)1.0 orientation:imageOrientation];

    // Release the Quartz image
    CGImageRelease(quartzImage);

    return image;
}

- (void)onRtspData:(Byte *)data len:(int)len width:(int)width height:(int)height {
    // NSLog(@"[RtspDemoViewController] onRtspData  len:%d", len);

    dispatch_async(_videoQueue, ^{
            UIImage *img = [self imageWithRGBData:data
            width   :width
            height  :height];

            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = img;

                if (!_activityIndicatorView.hidden) {
                    _activityIndicatorView.hidden = YES;
                }
            });
        });
}

- (void)palyWithUrl:(NSString *)url {
    if (_handler != 0) {
        destroyClient(&_handler);
        _imageView.image = nil;
        _handler = 0;
    }

    if (_activityIndicatorView.hidden) {
        _activityIndicatorView.hidden = NO;
    }

    const char  *expr = [url UTF8String];
    char        *pRealUrl = new char[strlen(expr) + 1];
    strcpy(pRealUrl, expr);

    int isUDP = 0;     // always USE TCP
    int res = initClient(&_handler, pRealUrl, rtspCallBack, isUDP);

    if (res == 0) {
        printf("rtsp connect failed!!!\n");
        
        [WLUIUtil showSimpleAlert:@"打开失败,视频可能不存在"];
    }
}

- (void)onStop {
    NSLog(@"RtspDemoViewController  onStop");

    if (_handler != 0) {
        destroyClient(&_handler);
        _imageView.image = nil;
        _handler = 0;
    }

    if (!_activityIndicatorView.hidden) {
        _activityIndicatorView.hidden = YES;
    }
}

#pragma -mark   life cycle

-(void)viewDidLoad
{
    _videoQueue = dispatch_queue_create("RtspVideoQueue", NULL);
    _rtspDemoViewController = self;

}

- (void)viewWillAppear:(BOOL)animated {
}



@end
