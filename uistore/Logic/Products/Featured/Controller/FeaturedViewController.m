//
//  FeaturedViewController.m
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "FeaturedViewController.h"

#import "UIImage+BlurredFrame.h"
#import "ColorUtils.h"
#import "UIUtils.h"

#import "Product.h"
#import "ProductManager.h"

#import "FeaturedProductView.h"

#import "CategoryViewController.h"
#import "Genre.h"

#import "Theme.h"
#import "ThemeManager.h"

#import "ProductDetailsViewController.h"

@interface FeaturedViewController () {
    UIImage* selectedImage;
    UIImage* normalImage;
}

- (void)updatePageDots;

@end

@implementation FeaturedViewController

#pragma mark -
#pragma mark Controller Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier compare:@"productListingToDetailsSegue"] == NSOrderedSame) {
        ((ProductDetailsViewController*)segue.destinationViewController).product = sender;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the back button without text for the upcoming views
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    // Build the images of the dots
    selectedImage = [UIImage imageNamed:@"Selected Page Dot"];
    normalImage = [UIImage imageNamed:@"Normal Page Dot"];
    
    // Load all the featued products
//    featuredItems = [[ProductManager sharedInstance] featuedProducts];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblMen];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblWomen];
    
    
    [[RequestManager manager] requestGetWithAction:@"api/site/feature" parameters:nil finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg) {
        if (isSuccess) {
            NSMutableArray *list = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                Product *product = [[Product alloc] initWithDictionary:dic];
                [list addObject:product];
            }
            featuredItems = list;
            [self buildSubviews];
        }else {
            [Toast showText:msg];
        }
    }];
}

- (void)buy:(UIButton *)sender {
//    ProductDetailsViewController *vc = [ProductDetailsViewController
    [self performSegueWithIdentifier:@"Detail" sender:featuredItems[sender.tag]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Show the navigation bar if it was hidden from previous UIs
    self.navigationController.navigationBarHidden = NO;
    
    // Add the side menu button
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Side Menu Icon"]
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(btnSideMenuAction:)];
    self.navigationItem.leftBarButtonItem = barButton;
    
    // Set the navigation bar background image
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"Featured Products"
                               withTag:TAG_NAV_BAR_BACKGROUND];
}

- (void)buildSubviews {
    // Create the products views
    float x = 0;
    for (int i = 0; i < featuredItems.count; i++) {
        FeaturedProductView* productView = [[NSBundle mainBundle] loadNibNamed:@"FeaturedProductView" owner:self options:nil][0];
        productView.frame = CGRectMake(x, 0, self.productsContainer.frame.size.width, self.productsContainer.frame.size.height);
        
        // Fill it with data
        Product* product = featuredItems[i];
        productView.lblTitle.text = product.name;
        productView.lblPrice.text = product.price;
        
        // Try to apply blur effect to the buttom part of the image
//        float blurredAreaHeight = productView.titleView.frame.size.height * 2;
//        CGRect frame = CGRectMake(0, product.featuredImage.size.height - blurredAreaHeight, product.featuredImage.size.width, blurredAreaHeight);
//        productView.imgProduct.image = [product.featuredImage applyLightEffectAtFrame:frame];
        [productView.imgProduct setImageWithURL:[NSURL URLWithString:product.imageURL]];
        
        
        productView.btn.tag = i;
        [productView.btn addTarget:self action:@selector(buy:)];
        // Apply Custom Font
        [[ThemeManager sharedInstance] applyCustomFont:EXO_FONT_BASE_NAME
                                             accessory:EXO_FONT_ACCESSORY_EXTRA_BOLD
                                               toLabel:productView.lblTitle];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                               toLabel:productView.lblPrice];
        
        // Add the view to the container and change the location for the next view
        [self.productsContainer addSubview:productView];
        x += productView.frame.size.width;
    }
    
    // Set the pager settings
    self.pager.numberOfPages = featuredItems.count;
    [self updatePageDots];
    
    self.productsContainer.contentSize = CGSizeMake(x, self.productsContainer.frame.size.height);
}


#pragma mark -
#pragma mark Events

- (IBAction)btnSideMenuAction:(id)sender {
    [((AppDelegate*)[UIApplication sharedApplication].delegate).sideMenuController openLeftMenu];
}

#pragma mark -
#pragma mark Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    self.pager.currentPage = page;
    [self updatePageDots];
}

- (void)updatePageDots {
    [[UIUtils sharedInstance] setPagesImagesInControl:self.pager
                                        selectedImage:selectedImage
                                          normalImage:normalImage];
}

@end
