//
//  ProductManager.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductCategory;

@interface ProductManager : NSObject

+ (ProductManager*)sharedInstance;

- (NSArray*)featuedProducts;
- (NSArray*)categoryProducts:(ProductCategory*)category;

@end
