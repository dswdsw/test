#import "MPPhotoPickerData.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MPPhotoPickerData

+ (MPPhotoPickerData *)sharedInstance {
    static dispatch_once_t      onceToken;
    static MPPhotoPickerData    *sSharedInstance;

    dispatch_once(&onceToken, ^{
            sSharedInstance = [[MPPhotoPickerData alloc] init];
        });
    return sSharedInstance;
}

- (void)clearData {
    self.selectIndexs = [NSMutableArray new];
    self.photoAssets = [NSArray new];
}

- (instancetype)init {
    self = [super init];

    if (self) {
        self.selectIndexs = [NSMutableArray new];
    }

    return self;
}

- (NSUInteger)photoCount {
    return self.photoAssets.count;
}

- (UIImage *)photoAtIndex:(NSUInteger)index {
    ALAsset *photoAsset = self.photoAssets[index];

    ALAssetRepresentation *assetRepresentation = [photoAsset defaultRepresentation];

    UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]
                                        scale           :[assetRepresentation scale]
                                        orientation     :ALAssetOrientationUp];

    return fullScreenImage;
}

@end
