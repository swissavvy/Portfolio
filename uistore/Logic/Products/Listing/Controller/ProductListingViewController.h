//
//  ProductListingViewController.h
//  uistore
//
//  Created  on 8/27/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductCategory;

@interface ProductListingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) ProductCategory* cateogry;

@property (weak, nonatomic) IBOutlet UIView* container;

@end
