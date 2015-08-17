//
//  LeftSideMenuTableViewController.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "AMSlideMenuLeftTableViewController.h"

@class SideMenuItem;

@interface LeftSideMenuTableViewController : AMSlideMenuLeftTableViewController<UITextFieldDelegate> {
    @private
    NSArray* items;
}

- (SideMenuItem*)itemAtIndex:(long)index;

@end
