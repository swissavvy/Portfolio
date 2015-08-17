//
//  MainSideMenuViewController.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "MainSideMenuViewController.h"

#import "LeftSideMenuTableViewController.h"
#import "SideMenuItem.h"

@interface MainSideMenuViewController ()

@end

@implementation MainSideMenuViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Store this instance to be used later for side menu manipulation (usually open and close)
    ((AppDelegate*)[UIApplication sharedApplication].delegate).sideMenuController = self;
}

#pragma mark -
#pragma mark Side Menu Methods

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath {
    // Ask the side menu for the selected item
    LeftSideMenuTableViewController* sideMenu = (LeftSideMenuTableViewController*)self.leftMenu;
    SideMenuItem* item = [sideMenu itemAtIndex:indexPath.row];
    if (item == nil) {
        if (![User sharedInstance].isLogin) {
            return @"menuLoginSegue";
        }else {
            return @"menuFeaturedSegue";
        }
        
    }
    else {
        return item.segue;
    }
}

- (void)configureLeftMenuButton:(UIButton *)button {
    button.frame = CGRectMake(-15, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"Side Menu Icon"] forState:UIControlStateNormal];
}

@end
