//
//  ProductListingViewController.m
//  uistore
//
//  Created  on 8/27/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductListingViewController.h"

#import "ProductGridView.h"
#import "ProductTableViewCell.h"
#import "ProductDetailsViewController.h"

#import "ProductManager.h"
#import "ProductCategory.h"
#import "Product.h"

#import "ThemeManager.h"
#import "Theme.h"

#import "UIImage+BlurredFrame.h"
#import "UIUtils.h"

#import "RefreshTableView.h"

#define LISTING_METHOD_LIST_SMALL_IMAGES 0
#define LISTING_METHOD_LIST_LARGE_IMAGES 1
#define LISTING_METHOD_GRID              2

#define TAG_CURRENT_VIEW 2112

@interface ProductListingViewController ()<RefreshTableViewDelegate> {
    int listingMethod;
    
    RefreshTableView* _tableView;
    UIScrollView* collectionProducts;
    
    Product* productToShowDetails;
    
    
    NSString *_startKey;
    
    NSMutableArray *_dataList;
    
    BOOL _isReload;
}

- (void)reloadData;

@end

@implementation ProductListingViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier compare:@"productListingToDetailsSegue"] == NSOrderedSame) {
        ((ProductDetailsViewController*)segue.destinationViewController).product = productToShowDetails;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    // Set the top bar background
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:self.cateogry.name
                               withTag:TAG_NAV_BAR_BACKGROUND];

    // Build the right menu item (to change listing method)
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 26, 26);
    [button setImage:[UIImage imageNamed:@"Listing Method Button"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(listingMethodButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Back button for the next views without a title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    
    // Set the default viewing method to big images list and reload the data into the UI
    listingMethod = LISTING_METHOD_LIST_LARGE_IMAGES;
    [self reloadData];
    
    _dataList = [NSMutableArray array];
    
    [self requestFirstPage];
}

#pragma mark -
#pragma mark Events

- (void)listingMethodButtonTapped {
    UIActionSheet* listingMethodsSheet = [[UIActionSheet alloc] initWithTitle:@"Choose a view method"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"List: Small Images", @"List: Large Images", nil];
    [listingMethodsSheet showInView:self.navigationController.view];
}

#pragma mark -
#pragma mark Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        listingMethod = (int)buttonIndex;
        [self reloadData];
    }
}

#pragma mark -
#pragma mark Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* reuseId = @"";
    NSString* nibName = @"";
    if (listingMethod == LISTING_METHOD_LIST_SMALL_IMAGES) {
        reuseId = @"smallImageProductCell";
        nibName = @"SmallImageProductTableViewCell";
    }
    else if (listingMethod == LISTING_METHOD_LIST_LARGE_IMAGES) {
        reuseId = @"bigImageProductCell";
        nibName = @"BigImageProductTableViewCell";
    }
    
    ProductTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = (ProductTableViewCell*)[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil][0];
    }
    
    Product* product = _dataList[indexPath.row];
    cell.lblName.text = product.name;
    cell.lblPrice.text = product.price;
    
    // Fill the correct image
   /*
    if (listingMethod == LISTING_METHOD_LIST_SMALL_IMAGES) {
        cell.imgProduct.image = product.smallImage;
    }
    else if (listingMethod == LISTING_METHOD_LIST_LARGE_IMAGES) {
        cell.imgProduct.image = product.largeImage;
    }
    */
    [cell.imgProduct setImageWithURL:[NSURL URLWithString:product.imageURL]];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:EXO_FONT_BASE_NAME
                                         accessory:EXO_FONT_ACCESSORY_EXTRA_BOLD
                                           toLabel:cell.lblName];
    if (listingMethod == LISTING_METHOD_LIST_SMALL_IMAGES) {
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                               toLabel:cell.lblPrice];
    }
    else if (listingMethod == LISTING_METHOD_LIST_LARGE_IMAGES) {
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                               toLabel:cell.lblPrice];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (listingMethod == LISTING_METHOD_LIST_SMALL_IMAGES) {
        return 100.0f;
    }
    else if (listingMethod == LISTING_METHOD_LIST_LARGE_IMAGES) {
        return 209.0f;
    }
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    productToShowDetails = _dataList[indexPath.row];
    [self performSegueWithIdentifier:@"productListingToDetailsSegue" sender:self];
}

#pragma mark -
#pragma mark Events

- (void)gridProductViewTapped:(id)sender {
    int tag = (int)((UIGestureRecognizer*)sender).view.tag;
    productToShowDetails = _dataList[tag];
    [self performSegueWithIdentifier:@"productListingToDetailsSegue" sender:self];
}

#pragma mark -
#pragma mark Private Methods

- (void)reloadData {
    // Remove the old view from the container
    [[self.container viewWithTag:TAG_CURRENT_VIEW] removeFromSuperview];
    
    // Add the new view to the container
    if ((listingMethod == LISTING_METHOD_LIST_SMALL_IMAGES) || (listingMethod == LISTING_METHOD_LIST_LARGE_IMAGES)) {
        if (_tableView == nil) {
            _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)];
            _tableView.tag = TAG_CURRENT_VIEW;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.backgroundColor = [UIColor clearColor];
            
            _tableView.refreshDelegate = self;
            _tableView.refreshType = RefreshTypeBoth;
        }
        
        [self.container addSubview:_tableView];
        [_tableView reloadData];
    }
}


#pragma refresh

- (void)requestFirstPage {
    NSDictionary *params = @{
                             @"search"  : @"",
                             @"category_id" : STR_FROM_INT(_cateogry.ID),
                             @"start_key" : @"",
                             @"page_size" : @"20"
                             };
    
    _isReload = YES;
    [self requestWithParams:params];
}

- (void)requestNextPage {
    NSDictionary *params = @{
                             @"search"  : @"",
                             @"category_id" : STR_FROM_INT(_cateogry.ID),
                             @"start_key" : _startKey ? _startKey : @"",
                             @"page_size" : @"20"
                             };
    _isReload = NO;
    [self requestWithParams:params];
}

- (void)requestWithParams:(NSDictionary *)params {
    [[RequestManager manager] requestGetWithAction:@"api/product/index" parameters:params finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSDictionary *data, NSString *msg) {
        [_tableView finishLoading];
        
        if (isSuccess) {
            _tableView.isLoadFailed = NO;
            
            int pageCount = [data[@"page_count"] intValue];
            _startKey = data[@"start_key"];
            
            if (_isReload) {
                [_dataList removeAllObjects];
            }
            for (NSDictionary *dic in data[@"list"]) {
                Product *product = [[Product alloc] initWithDictionary:dic];
                [_dataList addObject:product];
            }
            if (pageCount <= _dataList.count) {
                _tableView.isLoadedAllTheData = YES;
            }
            
            [_tableView reloadData];
        }else {
            _tableView.isLoadFailed = YES;
            [Toast showText:msg];
        }
    }];
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_tableView refreshTableViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_tableView refreshTableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_tableView refreshTableViewDidEndDragging:scrollView];
}


- (void)refreshTableViewRequestHeaderDataSoure:(RefreshTableView *)tableView {
    [self requestFirstPage];
}

- (void)refreshTableViewRequestFooterDataSoure:(RefreshTableView *)tableView {
    [self requestNextPage];
}

@end
