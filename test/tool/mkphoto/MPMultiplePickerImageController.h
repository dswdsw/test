//
//  MutilatePickerImageController.h
//  MyImagePicker
//
//  Created by stephen on 15/2/5.
//
//
//
//

#import <UIKit/UIKit.h>

@protocol MPMultiplePickerDeleagte<NSObject>

- (void)didSelectImages:(NSArray *)images;

@end

@interface MPMultiplePickerImageController : UINavigationController

- (void)show:(UIViewController *)controller;
+ (instancetype)initPicker;
@property (nonatomic , assign ) int  maxSelect;

@property (nonatomic, weak) id<MPMultiplePickerDeleagte> multipleDelegate;

@end
