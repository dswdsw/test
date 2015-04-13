#import <Foundation/Foundation.h>

@interface MPPhotoPickerData : NSObject

+ (MPPhotoPickerData *)sharedInstance;

@property (nonatomic , assign ) int maxSelect;

@property (nonatomic, strong) NSArray *photoAssets; // array of ALAsset objects

@property (nonatomic, strong)  NSMutableArray *selectIndexs;

- (NSUInteger)photoCount;

- (UIImage *)photoAtIndex:(NSUInteger)index;

- (void)clearData;




@end
