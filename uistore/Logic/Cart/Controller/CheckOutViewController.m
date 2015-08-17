//
//  CheckOutViewController.m
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CheckOutViewController.h"

#import "Cart.h"
#import "CartManager.h"
#import "Product.h"
#import "ProductSize.h"
#import "ProductColour.h"

#import "CheckoutTableViewCell.h"

#import "ThemeManager.h"
#import "Theme.h"

#import "UserManager.h"
#import "VLUser.h"

#import "UIUtils.h"

@interface CheckOutViewController ()

- (void)reloadData;

@end

@implementation CheckOutViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"Checkout"
                               withTag:TAG_NAV_BAR_BACKGROUND];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadData];
    
    // Apply theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnConfirm];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnCancel];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnCancel];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnConfirm];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblName];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblConfirmation];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblTotalPrice];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblTotalPriceTitle];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblShippingCost];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_BOLD
                                           toLabel:self.lblShippingCostTitle];
}

#pragma mark -
#pragma mark Events

- (IBAction)btnConfirmTouchUpInside:(id)sender {
    UIAlertView* confirmation = [[UIAlertView alloc] initWithTitle:@"Order Confirmation"
                                                           message:@"Are you sure you want to buy these items?"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"OK", nil];
    [confirmation show];
}

- (IBAction)btnCancelTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Alert View Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // He wants to buy, assume he bought and show a confirmation message
        UIAlertView* confirmation = [[UIAlertView alloc] initWithTitle:@"Done"
                                                               message:@"You have successfully bought the selected items"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [confirmation show];
        
        // Clear the cart
        [[CartManager sharedInstnace] clearCart];
        [self reloadData];
    }
}

#pragma mark -
#pragma mark Table Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cart.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckoutTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"checkoutItemCell"];
    
    Product* product = cart.items[indexPath.row];
    cell.lblTitle.text = product.name;
    cell.lblPrice.text = [NSString stringWithFormat:PRICE_TEMPLATE, (product.selectedQuantity * product.numericPrice)];
    cell.lblQuantity.text = [NSString stringWithFormat:@"%d", product.selectedQuantity];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_BOLD
                                           toLabel:cell.lblTitle];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:cell.lblQuantity];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:cell.lblPrice];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Load the header view
    UIView* header = [[NSBundle mainBundle] loadNibNamed:@"CheckoutTableHeader" owner:self options:nil][0];
    
    // Apply custom font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblItemsHeaderTitle];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblItemsHeaderQuantity];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblItemsHeaderPrice];
    
    return header;
}

#pragma mark -
#pragma mark Private Methods

- (void)reloadData {
    cart = [[CartManager sharedInstnace] currentCart];
    
    // Fill the user's information
    self.lblName.text = [[UserManager sharedInstance] currentUser].name;

    // Fill the general information
    self.lblTotalPrice.text = [NSString stringWithFormat:@"%@%.02f", CURRENCY, (cart.totalPrice + SHIPPING_COST)];
    self.lblShippingCost.text = [NSString stringWithFormat:@"%@%.02f", CURRENCY, SHIPPING_COST];
    
    [self.tblItems reloadData];
}

@end
