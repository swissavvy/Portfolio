//
//  LeftSideMenuTableViewController.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "LeftSideMenuTableViewController.h"

#import "SearchTableViewCell.h"
#import "SideMenuTableViewCell.h"

#import "SideMenuManager.h"
#import "SideMenuItem.h"

#import "Genre.h"
#import "CategoryViewController.h"

#import "Theme.h"
#import "ThemeManager.h"

@interface LeftSideMenuTableViewController () {
    UITextField* currentSearchField;
    long lastRequestedIndex;
}

@end

@implementation LeftSideMenuTableViewController

#pragma mark -
#pragma mark Controller Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menuLoginSegue"]) {
        [[User sharedInstance] logOut];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Change table background image
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    
    lastRequestedIndex = -1;
    // Load side menu items
    items = [[SideMenuManager sharedInstance] sideMenuItems];
}

#pragma mark -
#pragma mark Methods

- (SideMenuItem*)itemAtIndex:(long)index {
    if (index > 0) {
        lastRequestedIndex = index;
        return items[index - 1];
    }
    
    if ((lastRequestedIndex > 0) && (lastRequestedIndex < items.count)) {
        return items[lastRequestedIndex - 1];
    }
    
    lastRequestedIndex = 1;
    return nil;
}

#pragma mark -
#pragma mark Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count + 1; // +1 for the search cell at the top
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
        
        // Apply theming and custom font
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toTextField:cell.txtKeyword];
        // Add rounding
        [cell.txtKeyword clipsToBounds];
        cell.txtKeyword.layer.cornerRadius = ROUNDED_RECT_RADIUS;
        
        // Add search icon
        UIImageView *paddingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Side Menu Search"]];
        cell.txtKeyword.leftView = paddingView;
        cell.txtKeyword.leftViewMode = UITextFieldViewModeAlways;
        [cell.txtKeyword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        // Save a reference for later keyboard processing
        currentSearchField = cell.txtKeyword;
        
        return cell;
    }
    else {
        SideMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
        
        SideMenuItem* item = items[indexPath.row - 1];
        cell.imgIcon.image = item.image;
        cell.lblTitle.text = item.name;
        
        // Apply Custom Font
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                               toLabel:cell.lblTitle];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 86.0f;
    }
    else {
        return 62.0f;
    }
}

#pragma mark -
#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
