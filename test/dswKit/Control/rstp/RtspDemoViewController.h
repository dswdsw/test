//
//  RtspDemoViewController.h
//  RtspDemo
//
//  Created by cj on 12-6-27.
//  Copyright 2012 kaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RtspDemoViewController : UIViewController {
    IBOutlet UIImageView *_imageView;
    IBOutlet UIActivityIndicatorView *_activityIndicatorView;
    
	dispatch_queue_t _videoQueue;
    int _handler;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (void)onRtspData:(Byte *)data len:(int)len width:(int)width height:(int)height;

- (void)onStop ;

- (void)palyWithUrl:(NSString *)url;

@end

