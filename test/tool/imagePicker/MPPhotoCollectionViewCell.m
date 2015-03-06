//
//  PhotoCollectionViewCell.m
//  MyImagePicker
//
//  Created by stephen on 15/2/5.
//
//

#import "MPPhotoCollectionViewCell.h"

@implementation MPPhotoCollectionViewCell

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    [self show];
}

- (void)show {
    if (_isChecked) {
        self.selectedImg.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.layer.opacity = 0.8;
        }];
        
    } else {
        self.selectedImg.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.layer.opacity = 1;
        }];
        
    }
}

@end
