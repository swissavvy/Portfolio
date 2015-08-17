//
//  Product.m
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "Product.h"

#import "ProductSize.h"
#import "ProductColour.h"

//"id": "152",
//"name": "Daily Allotment",
//"category_id": "0",
//"cover": "http://packages.asiatravel.com/packageImage/Package/at-bus-90x65.jpg",
//"description": "sdfsafsaf asfasfsaf<br>",
//"create_date": "2015-06-27 21:15:17"

#define PRODUCT_ID         @"id"
#define PRODUCT_NAME       @"name"

#define PRODUCT_FEATURED_IMAGE @"cover"
#define PRODUCT_SMALL_IMAGE    @"cover"
#define PRODUCT_LARGE_IMAGE    @"cover"
#define PRODUCT_GRID_IMAGE     @"cover"

#define PRODUCT_DETAILS    @"description"
#define PRODUCT_PRICE      @"price"

#define PRODUCT_IMAGES     @"Images"
#define PRODUCT_IMAGE_NAME @"ImageName"

#define PRODUCT_SIZES   @"Sizes"
#define PRODUCT_COLOURS @"Colours"

@implementation Product

- (id)initWithProduct:(Product*)product {
    if (self = [super init]) {
        self.ID = product.ID;
        self.name = product.name;
        self.price = product.price;
        self.details = product.details;
        self.brandInformation = product.brandInformation;
        _numericPrice = product.numericPrice;
        self.featuredImage = product.featuredImage;
        self.smallImage = product.smallImage;
        self.largeImage = product.largeImage;
        self.gridImage = product.gridImage;
        self.images = [[NSArray alloc] initWithArray:self.images];
        self.sizes = [[NSArray alloc] initWithArray:self.sizes];
        self.colours = [[NSArray alloc] initWithArray:self.colours];
        self.selectedQuantity = product.selectedQuantity;
        self.selectedColour = product.selectedColour;
        self.selectedSize = product.selectedSize;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dataDictionary {
    if (self = [super init]) {
        [self parse:dataDictionary];
    }
    
    return self;
}

- (BOOL)parse:(NSDictionary *)dataDictionary {
    if (dataDictionary == nil) {
        return NO;
    }
    
    // Basic information
    self.ID = [dataDictionary[PRODUCT_ID] longLongValue];
    self.name = dataDictionary[PRODUCT_NAME];
    if (self.name == nil) {
        self.name = dataDictionary[@"product_name"];
    }
    self.price = [NSString stringWithFormat:@"%@%@", CURRENCY, dataDictionary[PRODUCT_PRICE]];
    self.details = dataDictionary[PRODUCT_DETAILS];
    self.brandInformation = [NSString stringWithFormat:@"A great brand %@", self.details]; // Just some dummy text
    
    _numericPrice = [dataDictionary[PRODUCT_PRICE] floatValue];
    
    
    // Cover images
    self.featuredImage = [UIImage imageNamed:dataDictionary[PRODUCT_FEATURED_IMAGE]];
    self.smallImage = [UIImage imageNamed:dataDictionary[PRODUCT_SMALL_IMAGE]];
    self.largeImage = [UIImage imageNamed:dataDictionary[PRODUCT_LARGE_IMAGE]];
    self.gridImage = [UIImage imageNamed:dataDictionary[PRODUCT_GRID_IMAGE]];
    
    self.imageURL = dataDictionary[@"cover"];
    if (self.imageURL == nil) {
        self.imageURL = dataDictionary[@"image"];
    }
    
    self.selectedQuantity = [dataDictionary[@"quantity"] intValue];
    
    // Images
    NSArray* imagesDicts = dataDictionary[PRODUCT_IMAGES];
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:imagesDicts.count];
    for (NSDictionary* imageDict in imagesDicts) {
        [result addObject:[UIImage imageNamed:imageDict[PRODUCT_IMAGE_NAME]]];
    }
    self.images = result;
    
    // Sizes
    NSArray* sizesDicts = dataDictionary[PRODUCT_SIZES];
    result = [[NSMutableArray alloc] initWithCapacity:sizesDicts.count];
    for (NSDictionary* sizeDict in sizesDicts) {
        [result addObject:[[ProductSize alloc] initWithDictionary:sizeDict]];
    }
    self.sizes = result;
    
    // Colours
    NSArray* coloursDicts = dataDictionary[PRODUCT_COLOURS];
    result = [[NSMutableArray alloc] initWithCapacity:coloursDicts.count];
    for (NSDictionary* colourDict in coloursDicts) {
        [result addObject:[[ProductColour alloc] initWithDictionary:colourDict]];
    }
    self.colours = result;
                            
    return YES;
}

@end
