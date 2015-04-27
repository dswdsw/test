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
    
    NSMutableArray *images=[NSMutableArray new];
    
    for (int i=0; i< [MPPhotoPickerData sharedInstance].photoAssets.count ; i++) {
        [images addObject:[[MPPhotoPickerData sharedInstance] photoAtIndex:i]];
    }
    [self.multipleDelegate didSelectImages:images];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)show:(UIViewController *)controller {
    [controller presentViewController:self animated:YES completion:nil];
}

-(void)setMaxSelect:(int)maxSelect
{
    _maxSelect=maxSelect;
    [MPPhotoPickerData sharedInstance].maxSelect=_maxSelect;
}

@end
