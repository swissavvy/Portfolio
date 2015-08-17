//
//  CategoryDelegate.h
//  uistore
//
//  Created  on 12/7/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CategoryDelegate <NSObject>

@optional

- (void)categoriesFetchDidFailWithError:(NSError*)error;
- (void)categoriesFetchDidSucceedWithData:(NSArray*)categories; // Array of ProductCategory objects

@end
