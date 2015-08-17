//
//  CategoryViewController.h
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryDelegate.h"

@class Genre;

@interface CategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CategoryDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
