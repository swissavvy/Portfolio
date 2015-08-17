//
//  ProductDetailsViewController.m
//  uistore
//
//  Created  on 8/31/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductDetailsViewController.h"

#import "Product.h"
#import "ProductColour.h"
#import "ProductSize.h"

#import "UIImage+BlurredFrame.h"
#import "UIUtils.h"
#import "CircleView.h"

#import "Theme.h"
#import "ThemeManager.h"
#import "UIActionSheet+BDAddition.h"
#import "CartManager.h"
#import "User.h"

#define TAG_COLOURS_SHEET 231
#define TAG_SIZES_SHEET   232

#define TAG_COLOUR_CIRCLE 233

@interface ProductDetailsViewController () {
    UIImage* selectedImage;
    UIImage* normalImage;
    
    UIView* detailsTestView;
    BOOL dataLoaded;
    
    __weak IBOutlet UIButton *attributeBtn;
    // This is the size of the labels that could stretch
    float originalLabelsHeight;
}

- (void)reloadData;

- (void)reloadImages;
- (void)reloadDetails;
- (void)reloadColour:(ProductColour*)colour;
- (void)reloadSize:(ProductSize*)size;
- (void)reloadQuantity:(int)quantity;

@end

@implementation ProductDetailsViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Build the images of the dots
    selectedImage = [UIImage imageNamed:@"Selected Page Dot"];
    normalImage = [UIImage imageNamed:@"Normal Page Dot"];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblPrice];
    [[ThemeManager sharedInstance] applyCustomFont:EXO_FONT_BASE_NAME
                                         accessory:EXO_FONT_ACCESSORY_EXTRA_BOLD
                                           toLabel:self.lblTitle];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblSize];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblSizeTitle];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblQuantity];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblQuantityTitle];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblColourTitle];
    
    SHOW_LOADING;
    [[RequestManager manager] requestGetWithAction:@"api/product/view" parameters:@{@"id" : @(_product.ID)} finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            self.product.name = data[@"name"];
            self.product.details = data[@"description"];
            self.product.imageURL = data[@"cover"];
            self.product.attributes = data[@"attributes"];
            [self reloadData];
        }else {
            [Toast showText:msg];
        }
    }];
}

- (IBAction)changeAttribute:(id)sender {
    if (self.product.attributes.count == 0) {
        [Toast showText:@"sorry, there is no attribute"];
        return;
    }
    
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in self.product.attributes) {
        [list addObject:dic[@"name"]];
    }
    UIActionSheet *sheet = [UIActionSheet actionSheetWithTitle:nil cancelTitle:@"Cancel" buttonTitles:list delegate:self];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in self.product.attributes) {
            [list addObject:dic[@"value"]];
        }
        NSString *value = list[buttonIndex];
        
        [attributeBtn setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark Events

- (IBAction)btnAddToCartTouchUpInside:(id)sender {
//    [[CartManager sharedInstnace] addProductToCart:self.product];
    SHOW_LOADING;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setKey:@"uid" object:[User sharedInstance].ID];
    [params setKey:@"quantity" object:@(self.product.selectedQuantity)];
    [params setKey:@"product_id" object:@(self.product.ID)];
    
    BDLogInfo(@"%@", params);
    
    [[RequestManager manager] requestPostWithAction:@"api/product/add-to-cart" parameters:params finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            UIAlertView* success = [[UIAlertView alloc] initWithTitle:@"Added to Cart"
                                                              message:@"The product was successfully added to your cart"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [success show];
        }else {
            [Toast showText:msg];
        }
    }];
    
    
}

- (IBAction)colourViewTapped:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a colour"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    sheet.tag = TAG_COLOURS_SHEET;
    for (ProductColour* colour in self.product.colours) {
        [sheet addButtonWithTitle:colour.name];
    }
    
    // Add the cancel button
    [sheet addButtonWithTitle:@"Cancel"];
    sheet.cancelButtonIndex = self.product.colours.count;
    
    // Show the sheet
    [sheet showInView:self.navigationController.view];
}

- (IBAction)sizeViewTapped:(id)sender {
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a size"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    sheet.tag = TAG_SIZES_SHEET;
    for (ProductSize* size in self.product.sizes) {
        [sheet addButtonWithTitle:size.name];
    }
    [sheet addButtonWithTitle:@"Cancel"];
    sheet.cancelButtonIndex = self.product.sizes.count;
    
    [sheet showInView:self.navigationController.view];
}

- (IBAction)quantityViewTapped:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Quantity"
                                                    message:@"Enter the required quantity"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];

    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
//    alertTextField.borderStyle = UITextBorderStyleRoundedRect;
//    alertTextField.backgroundColor = [UIColor whiteColor];
    alertTextField.text = [NSString stringWithFormat:@"%d", self.product.selectedQuantity];
    [alertTextField setTextAlignment:NSTextAlignmentCenter];
    [alert show];
    [alertTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // OK is tapped
        // Take the text and convert it to integer to indicate the required quantity
        int quantity = [((UITextField*)[alertView textFieldAtIndex:0]).text intValue];
        if (quantity != 0) {
            if (quantity > MAX_QUANTITY) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:MSG_MAX_QUANTITY_TITLE
                                                                message:MSG_MAX_QUANTITY_BODY
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                [self reloadQuantity:quantity];
            }
        }
    }
}

//#pragma mark -
//#pragma mark Action Sheet Delegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if ((buttonIndex >= 0) && (buttonIndex != actionSheet.cancelButtonIndex)) {
//        if (actionSheet.tag == TAG_SIZES_SHEET) {
//            [self reloadSize:self.product.sizes[buttonIndex]];
//        }
//        else if (actionSheet.tag == TAG_COLOURS_SHEET) {
//            [self reloadColour:self.product.colours[buttonIndex]];
//        }
//    }
//}

#pragma mark -
#pragma mark Private Methods

- (void)reloadData {
    [self reloadDetails];
    [self reloadImages];
//    if (self.product.colours.count > 0) {
//        [self reloadColour:self.product.colours[0]];
//    }
//    if (self.product.sizes.count > 0) {
//        [self reloadSize:self.product.sizes[0]];
//    }
    [self reloadQuantity:1];
    
    [self.view layoutSubviews];
}

- (void)reloadImages {
    float x = 0;
//    for (int i = 0; i < self.product.images.count; i++) {
//        // Build the new image
//        UIImage* imageObject = self.product.images[i];
//        UIImageView* image = [[UIImageView alloc] initWithImage:imageObject];
//        image.frame = CGRectMake(x, 0, self.imagesContainer.frame.size.width, self.imagesContainer.frame.size.height);
//        
//        // Try to apply blur effect to the buttom part of the image
//        float blurredAreaHeight = self.titleView.frame.size.height * 2;
//        CGRect frame = CGRectMake(0, imageObject.size.height - blurredAreaHeight, imageObject.size.width, blurredAreaHeight);
//        image.image = [imageObject applyLightEffectAtFrame:frame];
//        
//        // Add it to the parent container
//        [self.imagesContainer addSubview:image];
//        
//        // Set the x for the next image position
//        x += image.frame.size.width;
//    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imagesContainer.width, self.imagesContainer.height)];
    [imageView setImageWithURL:[NSURL URLWithString:self.product.imageURL]];
    [self.imagesContainer addSubview:imageView];
    
    
    self.imagesContainer.contentSize = CGSizeMake(self.product.images.count * self.imagesContainer.frame.size.width, self.imagesContainer.frame.size.height);
    self.pager.numberOfPages = self.product.images.count;
    [self updatePageDots];
}

- (void)reloadDetails {
    self.lblTitle.text = self.product.name;
    self.lblPrice.text = self.product.price;
    
    // Fill the scrollable details
    detailsTestView = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailsView"
                                                    owner:self
                                                  options:nil][0];
    originalLabelsHeight = self.lblDetails.frame.size.height + self.lblBrandInformation.frame.size.height;
//    self.lblDetails.text = self.product.details;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.product.details dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.lblDetails.attributedText = attrStr;
    
    
//    self.lblBrandInformation.text = self.product.brandInformation;
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblDetails];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblDetailsTitle];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblBrandInformation];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_LIGHT
                                           toLabel:self.lblBrandInformationTitle];
    [self.lblDetails sizeToFit];
    [self.lblBrandInformation sizeToFit];
    
    float newLabelsSize = self.lblDetails.frame.size.height + self.lblBrandInformation.frame.size.height;
    
    detailsTestView.frame = CGRectMake(0, 0, detailsTestView.frame.size.width, detailsTestView.frame.size.height + (newLabelsSize - originalLabelsHeight));
    [self.detailsContainer addSubview:detailsTestView];
    self.detailsContainer.contentSize = detailsTestView.frame.size;
}

- (void)reloadColour:(ProductColour*)colour {
    // Remove the old colour view
    if ([self.colourCircleContainer viewWithTag:TAG_COLOUR_CIRCLE] != nil) {
        [[self.colourCircleContainer viewWithTag:TAG_COLOUR_CIRCLE] removeFromSuperview];
    }
    
    // Create the new one
    CircleView* circle = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, self.colourCircleContainer.frame.size.width, self.colourCircleContainer.frame.size.height)
                                                    colour:colour.uiColor
                                                     alpha:1.0f];
    circle.opaque = NO;
    circle.backgroundColor = [UIColor clearColor];
    [self.colourCircleContainer addSubview:circle];
    
    // Set the new selected colour
    self.product.selectedColour = colour;
}

- (void)reloadSize:(ProductSize*)size {
    self.lblSize.text = size.name;
    self.product.selectedSize = size;
}

- (void)reloadQuantity:(int)quantity {
    self.lblQuantity.text = [NSString stringWithFormat:@"%d", quantity];
    self.product.selectedQuantity = quantity;
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
