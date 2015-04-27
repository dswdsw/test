#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface MPShowBigViewController : UIViewController<UIScrollViewDelegate, UINavigationControllerDelegate>
{
    UIButton        *rightbtn;
    UIScrollView    *_scrollerview;
    UIButton        *_btnOK;
}

@property(nonatomic, strong) NSMutableArray *arrayOK;     //选中的图片数组

@end
