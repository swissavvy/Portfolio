//
//  ProductManager.m
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ProductManager.h"

#import "VLPListParser.h"
#import "VLFileManager.h"

#import "Product.h"
#import "ProductCategory.h"

#define CATEGORY_PRODUCTS_FILENAME_TEMPLATE @"Category %lld"

@implementation ProductManager

+ (ProductManager*)sharedInstance {
    static ProductManager* instance = nil;
    if (instance == nil) {
        instance = [[ProductManager alloc] init];
    }
    
    return instance;
}

- (NSArray*)featuedProducts {
    NSString* filePath = [[VLFileManager sharedInstance] filePathInBundle:@"Featured Products" withExtention:@"plist"];
    NSArray* items = [[VLPListParser sharedInstance] parsePListData:[NSData dataWithContentsOfFile:filePath]
                                                           toObject:[Product class]];
    return items;
}

- (NSArray*)categoryProducts:(ProductCategory*)category {
    // Find the file
    NSString* productsFilePath = [NSString stringWithFormat:CATEGORY_PRODUCTS_FILENAME_TEMPLATE, category.ID];
    NSString* filePath = [[VLFileManager sharedInstance] filePathInBundle:productsFilePath withExtention:@"plist"];
    if (filePath == nil) {
        return nil;
    }
    
    // Load the data
    return [[VLPListParser sharedInstance] parsePListData:[NSData dataWithContentsOfFile:filePath]
                                                 toObject:[Product class]];
}

@end
