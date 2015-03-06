

#import "MPAssetsDataIsInaccessibleViewController.h"

@interface MPAssetsDataIsInaccessibleViewController ()
@property (nonatomic, strong) IBOutlet UITextView *explanationTextView;
@end

@implementation MPAssetsDataIsInaccessibleViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.explanationTextView.text = self.explanation;
}

@end
