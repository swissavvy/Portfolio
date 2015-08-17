//
//  CartViewController.m
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CartViewController.h"

#import "CartManager.h"
#import "Cart.h"

#import "Product.h"
#import "ProductSize.h"
#import "ProductColour.h"

#import "CartTableViewCell.h"

#import "ThemeManager.h"
#import "THeme.h"

#import "UIUtils.h"
#import "User.h"

@interface CartViewController ()

- (void)reloadData;

@end

@implementation CartViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"My Cart"
                               withTag:TAG_NAV_BAR_BACKGROUND];
    
    
    
    SHOW_LOADING;
    [[RequestManager manager] requestGetWithAction:@"api/product/my-cart" parameters:@{@"uid":[User sharedInstance].ID} finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            NSMutableArray *list = [NSMutableArray array];
            cart = [[Cart alloc] init];
            for (NSDictionary *dic in data) {
                Product *product = [[Product alloc] initWithDictionary:dic];
                [list addObject:product];
            }
            cart.items = list;
            // Get the cart and reload the data
//            cart = [[CartManager sharedInstnace] currentCart];
            if ((cart.items == nil) || (cart.items.count == 0)) {
                UIAlertView* noItemsMessage = [[UIAlertView alloc] initWithTitle:@"No Items"
                                                                         message:@"You don't have any items in your cart"
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                [noItemsMessage show];
            }
            
            [self reloadData];
        }else {
            [Toast showText:msg];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Apply theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnCheckout];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnClear];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnCheckout];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                          toButton:self.btnClear];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblTotalCount];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblTotalCountUnit];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblTotalPrice];
    
}

#pragma mark -
#pragma mark Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cart.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cartItemCell"];
    
    Product* cartItem = cart.items[indexPath.row];
    cell.lblName.text = cartItem.name;
    cell.lblPrice.text = cartItem.price;
    cell.lblQuantity.text = [NSString stringWithFormat:@"%d", cartItem.selectedQuantity];
    cell.lblSize.text = cartItem.selectedSize.name;
    cell.lblColour.text = cartItem.selectedColour.name;
//    cell.imgProduct.image = cartItem.smallImage;
    [cell.imgProduct setImageWithURL:[NSURL URLWithString:cartItem.imageURL]];
    
    // Apply theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:cell.lblQuantity];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_BOLD
                                           toLabel:cell.lblName];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:cell.lblColour];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:cell.lblSize];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:cell.lblPrice];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:cell.lblQuantity];
    
    return cell;
}

#pragma mark -
#pragma mark Events

- (IBAction)btnCheckoutTouchUpInside:(id)sender {
    // Execute some code before going to the checkout page
    if (cart.items.count == 0) {
        UIAlertView* noItemsMessage = [[UIAlertView alloc] initWithTitle:@"No Items"
                                                                 message:@"You don't have any items in your cart"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
        [noItemsMessage show];
    }
    else {
        [self performSegueWithIdentifier:@"cartCheckoutSegue" sender:self];
    }
}

- (IBAction)btnClearTouchUpInside:(id)sender {
    // Get a confirmation from the user
    UIAlertView* confirmation = [[UIAlertView alloc] initWithTitle:@"Clear Cart?"
                                                           message:@"Are you sure you want to clear the cart?"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"OK", nil];
    [confirmation show];
}

#pragma mark -
#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        cart = [[CartManager sharedInstnace] clearCart];
        [self reloadData];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)reloadData {
    // Load the header information
    self.lblTotalCount.text = [NSString stringWithFormat:@"%ld", cart.items.count];
    self.lblTotalPrice.text = [NSString stringWithFormat:@"$%.02f", cart.totalPrice];
    NSString* unit = ITEMS_SINGLULAR_UNIT;
    if (cart.items.count > 1) {
        unit = ITEMS_PLURAR_UNIT;
    }
    self.lblTotalCountUnit.text = unit;
    
    // Reload the items table
    [self.tblItems reloadData];
}

@end
