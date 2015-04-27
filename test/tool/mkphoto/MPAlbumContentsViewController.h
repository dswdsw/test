#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MPAlbumContentsViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
