//
//  MutilatePickerImageController.m
//  MyImagePicker
//
//  Created by stephen on 15/2/5.
//
//

#import "MPMultiplePickerImageController.h"
#import "MPPhotoPickerData.h"

@interface MPMultiplePickerImageController ()

@end

@implementation MPMultiplePickerImageController

+ (instancetype)initPicker {
    MPMultiplePickerImageController *controller = [[UIStoryboard storyboardWithName:@"MPPickerStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"picker"];

    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImage) name:@"pickerImageOK" object:nil];
}

- (void)getImage {
    [self.multipleDelegate didSelectImages:[MPPhotoPickerData sharedInstance].photoAssets];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)show:(UIViewController *)controller {
    [controller presentViewController:self animated:YES completion:nil];
}

@end
