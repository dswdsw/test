#import "MPShowBigViewController.h"
#import "MPPhotoPickerData.h"

#import "IndexArray.h"
#define IOS7LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@interface MPShowBigViewController ()<UIScrollViewDelegate>
{
    NSInteger page;

    NSMutableArray *indexSet;
}

@end

@implementation MPShowBigViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayOK = [[NSMutableArray alloc]initWithArray:[MPPhotoPickerData sharedInstance].photoAssets];

    [[MPPhotoPickerData sharedInstance].selectIndexs removeAllObjects];

    for (NSInteger i = 0; i < (NSInteger)self.arrayOK.count; i++) {
        [[MPPhotoPickerData sharedInstance].selectIndexs addNSInteger:i];
    }

    page = 0;
    indexSet = [NSMutableArray new];

    for (NSInteger i = 0; i < (NSInteger)self.arrayOK.count; i++) {
        [indexSet addNSInteger:i];
    }

    [self layOut];
    [self btnStatus];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;

    // 根据当前的x坐标和页宽度计算出当前页数
    page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self btnStatus];
}

#pragma  mark - 布局

- (void)layOut {
    self.view.backgroundColor = [UIColor blackColor];

    _btnOK = [UIButton buttonWithType:UIButtonTypeCustom];

    _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 61)];
    _btnOK.frame = CGRectMake(self.view.frame.size.width - 80, _scrollerview.frame.size.height + 8, 61, 32);

    _scrollerview.pagingEnabled = YES;
    _scrollerview.showsHorizontalScrollIndicator = NO;
    _scrollerview.delegate = self;
    // 显示选中的图片的大图

    _scrollerview.backgroundColor = [UIColor whiteColor];
    _scrollerview.delegate = self;

    for (int i = 0; i < (int)[self.arrayOK count]; i++) {
        ALAsset *asset = self.arrayOK[i];

        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollerview.frame.size.width, 0, _scrollerview.frame.size.width, _scrollerview.frame.size.height)];
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        imgview.clipsToBounds = YES;
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [imgview setImage:tempImg];
        [_scrollerview addSubview:imgview];
    }

    _scrollerview.contentSize = CGSizeMake((self.arrayOK.count) * (self.view.frame.size.width), 0);
    [self.view addSubview:_scrollerview];

    // 点击按钮，回到主发布页面

    [_btnOK setBackgroundImage:[UIImage imageNamed:@"PhotoComplete.png"] forState:UIControlStateNormal];
    [_btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    _btnOK.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnOK addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnOK];
}

#pragma  mark - 操作

//选中按钮
- (void)selectBtn {
    if ([indexSet containsNSInteger:page]) {
        // 取消选中
        [indexSet removeNSInteger:page];
    } else {
        //选中
        [indexSet addNSInteger:page];
    }

    [self btnStatus];
    [MPPhotoPickerData sharedInstance].selectIndexs = indexSet;
}

//按钮状态
- (void)btnStatus {
    // 勾选按钮

    NSString *imgName = @"";

    if ([indexSet containsNSInteger:page]) {
        //选中
        imgName = @"PhotoChecked";
    } else {
        // 取消
        imgName = @"NoPhotoChecked";
    }

    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(0, 0, 22, 22);
    [rightbtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    // 完成按钮
    [_btnOK setTitle:[NSString stringWithFormat:@"完成(%lu)", (unsigned long)indexSet.count] forState:UIControlStateNormal];

    if (indexSet.count == 0) {
        _btnOK.enabled = NO;
    } else {
        _btnOK.enabled = YES;
    }

    // 标题
    self.navigationItem.title = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)page + 1, (unsigned long)self.arrayOK.count];
}

- (void)complete:(UIButton *)sender {
    NSMutableArray *selectAssets = [NSMutableArray new];

    for (NSNumber *item in indexSet) {
        [selectAssets addObject:self.arrayOK[[item intValue]]];
    }

    [MPPhotoPickerData sharedInstance].photoAssets = selectAssets;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pickerImageOK" object:nil];
}

- (void)selectClick:(UIButton *)sender {
    [self selectBtn];
}

@end
