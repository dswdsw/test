#import "MPRootViewController.h"
#import "MPAlbumContentsViewController.h"
#import "MPAssetsDataIsInaccessibleViewController.h"
#import "MPPhotoPickerData.h"

@interface MPRootViewController ()

@property (nonatomic, strong) ALAssetsLibrary   *assetsLibrary;
@property (nonatomic, strong) NSMutableArray    *groups;

@end

#pragma mark -

@implementation MPRootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"照片";
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }

    if (self.groups == nil) {
        _groups = [[NSMutableArray alloc] init];
    } else {
        [self.groups removeAllObjects];
    }

    // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        MPAssetsDataIsInaccessibleViewController *assetsDataInaccessibleViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:@"inaccessibleViewController"];

        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;

            default:
                errorMessage = @"Reason unknown.";
                break;
        }

        assetsDataInaccessibleViewController.explanation = errorMessage;
        [self presentViewController:assetsDataInaccessibleViewController animated:NO completion:nil];
    };

    // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];

        if ([group numberOfAssets] > 0) {
            [self.groups addObject:group];
        } else {
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };

    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];

    
    [[ MPPhotoPickerData sharedInstance] clearData];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}

#pragma mark - UITableViewDataSource

// determine the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

// determine the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    ALAssetsGroup   *groupForCell = self.groups[indexPath.row];
    CGImageRef      posterImageRef = [groupForCell posterImage];
    UIImage         *posterImage = [UIImage imageWithCGImage:posterImageRef];

    cell.imageView.image = posterImage;
    cell.textLabel.text = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text = [@(groupForCell.numberOfAssets)stringValue];

    return cell;
}

#pragma mark - Segue support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];

        if (self.groups.count > (NSUInteger)selectedIndexPath.row) {
            // hand off the asset group (i.e. album) to the next view controller
            MPAlbumContentsViewController *albumContentsViewController = [segue destinationViewController];
            albumContentsViewController.assetsGroup = self.groups[selectedIndexPath.row];
        }
    }
}

- (IBAction)dimissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end
