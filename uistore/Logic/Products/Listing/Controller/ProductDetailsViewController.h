//
//  ProductDetailsViewController.h
//  uistore
//
//  Created  on 8/31/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ProductDetailsViewController : UIViewController<UIScrollViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView* imagesContainer;

@property (weak, nonatomic) IBOutlet UILabel* lblTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;

@property (weak, nonatomic) IBOutlet UIView* titleView;
@property (weak, nonatomic) IBOutlet UIPageControl* pager;

@property (weak, nonatomic) IBOutlet UIScrollView* detailsContainer;
@property (weak, nonatomic) IBOutlet UILabel* lblDetailsTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblDetails;
@property (weak, nonatomic) IBOutlet UILabel* lblBrandInformation;
@property (weak, nonatomic) IBOutlet UILabel* lblBrandInformationTitle;

@property (weak, nonatomic) IBOutlet UIView* colourContainer;
@property (weak, nonatomic) IBOutlet UIView* colourCircleContainer;
@property (weak, nonatomic) IBOutlet UILabel* lblColourTitle;

@property (weak, nonatomic) IBOutlet UIView* sizeContainer;
@property (weak, nonatomic) IBOutlet UILabel* lblSize;
@property (weak, nonatomic) IBOutlet UILabel* lblSizeTitle;

@property (weak, nonatomic) IBOutlet UIView* quantityConainer;
@property (weak, nonatomic) IBOutlet UILabel* lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel* lblQuantityTitle;

@property (weak, nonatomic) IBOutlet UIButton* btnAddToCart;

@property (strong, nonatomic) Product* product;

@end
