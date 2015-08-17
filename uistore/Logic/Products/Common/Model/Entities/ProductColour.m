//
//  ProductColour.m
//  uistore
//
//  Created  on 9/2/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductColour.h"

#import "ColorUtils.h"

#define PRODUCT_COLOUR_ID   @"ColourId"
#define PRODUCT_COLOUR_NAME @"ColourName"
#define PRODUCT_COLOUR_CODE @"ColourCode"

@implementation ProductColour

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
    
    self.ID = [dataDictionary[PRODUCT_COLOUR_ID] longLongValue];
    self.name = dataDictionary[PRODUCT_COLOUR_NAME];
    self.colourCode = dataDictionary[PRODUCT_COLOUR_CODE];
    
    _uiColor = [[ColorUtils sharedInstance] colorWithHexString:self.colourCode];
    
    return YES;
}

@end
