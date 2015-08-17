//
//  ProductCategory.m
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductCategory.h"

#define CATEGORY_ID   @"id"
#define CATEGORY_NAME @"label"

@implementation ProductCategory

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
    
    self.ID = [dataDictionary[CATEGORY_ID] longLongValue];
    self.name = dataDictionary[CATEGORY_NAME];
    
    return YES;
}

@end
