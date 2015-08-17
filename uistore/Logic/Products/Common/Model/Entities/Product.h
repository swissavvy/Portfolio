//
//  Product.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "VLDetailedObject.h"

#import "VLObjectParserProtocol.h"

@class ProductColour;
@class ProductSize;

@interface Product : VLDetailedObject<VLObjectParserProtocol>

@property (strong, nonatomic) NSString* brandInformation;

@property (strong, nonatomic) UIImage* featuredImage;
@property (strong, nonatomic) UIImage* smallImage;
@property (strong, nonatomic) UIImage* largeImage;
@property (strong, nonatomic) UIImage* gridImage;

@property (copy, nonatomic) NSString *imageURL;

@property (strong, nonatomic) NSArray *attributes;

@property (strong, nonatomic) NSString* price;
@property (nonatomic, readonly) float numericPrice;

// Array of UIImage objects
@property (strong, nonatomic) NSArray* images;

// Array of ProductSize objects
@property (strong, nonatomic) NSArray* sizes;

// Array of ProductColour objects
@property (strong, nonatomic) NSArray* colours;

// These are for the cart
@property (strong, nonatomic) ProductColour* selectedColour;
@property (strong, nonatomic) ProductSize* selectedSize;
@property (nonatomic) int selectedQuantity;

- (id)initWithProduct:(Product*)product;

@end
