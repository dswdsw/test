#import "MPAlbumContentsViewController.h"
#import "MPPhotoPickerData.h"
#import "MPPhotoCollectionViewCell.h"
#import "IndexArray.h"
#import "WLUIUtil.h"

@implementation MPAlbumContentsViewController
{
    NSMutableArray *selectSet;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    selectSet = [NSMutableArray new];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];

    //
    if (!self.assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }

    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    };

    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    //
    NSMutableArray *temp = [NSMutableArray new];

    
    for (NSNumber *item in [MPPhotoPickerData sharedInstance].selectIndexs) {
        if (selectSet.count==0) {
            break;
        }
        [temp addNSInteger:(NSInteger)((NSNumber *)selectSet[item.intValue]).intValue];
    }

    selectSet = temp;

    [self.collectionView reloadData];

    //
    [self btnStatus];
}

#pragma  mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = (collectionView.frame.size.width - 4 * 2 * 1) / 4;

    return CGSizeMake(width, width);
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    MPPhotoCollectionViewCell *cell = (MPPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (cell.isChecked) {
        cell.isChecked = NO;
        [selectSet removeNSInteger:indexPath.row];
    } else {
        if (selectSet.count>= [MPPhotoPickerData sharedInstance].maxSelect) {
            [WLUIUtil showSimpleAlert: [NSString stringWithFormat:@"你最多选择%i张图片",[MPPhotoPickerData sharedInstance].maxSelect]];
            return;
        }
        
        cell.isChecked = YES;
        [selectSet addNSInteger:indexPath.row];
    }

    [self btnStatus];
}

#define kImageViewTag 1 // the image view inside the collection view cell prototype is tagged with "1"

#pragma  mark - <UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"photoCell";

    MPPhotoCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    // load the asset for this cell
    ALAsset     *asset = self.assets[indexPath.row];
    CGImageRef  thumbnailImageRef = [asset thumbnail];
    UIImage     *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];

    // apply the image to the cell
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageViewTag];

    imageView.image = thumbnail;

    if ([selectSet containsNSInteger:indexPath.row]) {
        cell.isChecked = YES;
    } else {
        cell.isChecked = NO;
    }

    return cell;
}

#pragma mark - Segue support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPhoto"]) {
        [self getSelectPhotos];
    }
}

#pragma  mark - other

- (IBAction)doneClick:(id)sender {
    [self getSelectPhotos];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pickerImageOK" object:nil];
}

- (IBAction)dimissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)getSelectPhotos {
    NSMutableArray *selectAssets = [NSMutableArray new];

    for (NSNumber *item in selectSet) {
        [selectAssets addObject:self.assets[[item intValue]]];
    }

    [MPPhotoPickerData sharedInstance].photoAssets = selectAssets;
}

- (void)btnStatus {
    if (selectSet.count == 0) {
        self.toolbar.userInteractionEnabled = NO;
        self.toolbar.tintColor = [UIColor grayColor];
    } else {
        self.toolbar.userInteractionEnabled = YES;
        self.toolbar.tintColor = [UIColor blackColor];
    }

    [self.doneBtn setTitle:[NSString stringWithFormat:@"完成(%lu)", (unsigned long)selectSet.count]];
}

@end
