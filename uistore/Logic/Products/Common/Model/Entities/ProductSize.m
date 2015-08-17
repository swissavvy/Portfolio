//
//  ProductSize.m
//  uistore
//
//  Created  on 9/2/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductSize.h"

#define PRODUCT_SIZE_ID   @"SizeId"
#define PRODUCT_SIZE_NAME @"SizeName"

@implementation ProductSize

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
    
    self.ID = [dataDictionary[PRODUCT_SIZE_ID] longLongValue];
    self.name = dataDictionary[PRODUCT_SIZE_NAME];
    
    return YES;
}

@end
