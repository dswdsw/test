//
//  PhotoCollectionViewCell.h
//  MyImagePicker
//
//  Created by stephen on 15/2/5.
//
//

#import <UIKit/UIKit.h>

@interface MPPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;

@property (nonatomic, assign) BOOL isChecked;

- (void)show;

@end
