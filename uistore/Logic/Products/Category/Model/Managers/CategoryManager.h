//
//  CategoryManager.h
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CategoryDelegate.h"
#import "VLDataDelegate.h"

@class Genre;

@interface CategoryManager : NSObject<VLDataDelegate> {
    id<CategoryDelegate> delegateObject;
}

+ (CategoryManager*)sharedInstance;

- (NSArray*)categoriesForGenre:(Genre*)genre;

// A sample for online fetching
- (void)onlineCategoriesForGenre:(Genre*)genre withDelegate:(id<CategoryDelegate>)delegate;

@end
