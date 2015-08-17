//
//  CategoryManager.m
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CategoryManager.h"

#import "VLInternetManager.h"
#import "VLDataConstants.h"

#import "VLPListParser.h"
#import "VLFileManager.h"

#import "Genre.h"
#import "ProductCategory.h"

#define TAG_CATEGORIES @"genreCategories"
#define URL_CATEGORIES @"http://www.test.com/genreCategories?genreID=%lld"

@implementation CategoryManager

+ (CategoryManager*)sharedInstance {
    static CategoryManager* instance = nil;
    if (instance == nil) {
        instance = [[CategoryManager alloc] init];
    }
    
    return instance;
}

- (NSArray*)categoriesForGenre:(Genre*)genre {
    NSString* filePath = [[VLFileManager sharedInstance] filePathInBundle:@"Genres Categories" withExtention:@"plist"];
    NSArray* allGenres = [[VLPListParser sharedInstance] parsePListData:[NSData dataWithContentsOfFile:filePath]
                                                               toObject:[Genre class]];
    for (Genre* currentGenre in allGenres) {
        if (currentGenre.ID == genre.ID) {
            return currentGenre.categories;
        }
    }
    
    return nil;
}

- (void)onlineCategoriesForGenre:(Genre*)genre withDelegate:(id<CategoryDelegate>)delegate {
    delegateObject = delegate;
    
    // Build the url
    NSString* url = [NSString stringWithFormat:URL_CATEGORIES, genre.ID];
    
    // Pass whatever tag you need here so you could recognize it later when the response comes
    VLInternetManager* request = [[VLInternetManager alloc] initWithTempFileName:TAG_CATEGORIES
                                                                             url:url
                                                                        delegate:self
                                                                    responseType:RESPONSE_PLIST
                                                                      requestTag:TAG_CATEGORIES
                                                                   requestMethod:VL_REQUEST_GET
                                                                    resultObject:[ProductCategory class]];
    [request start];
}

#pragma mark -
#pragma mark Data Delegate

- (void)manager:(VLBaseDataManager *)manager didFailWithError:(NSError *)error requestTag:(NSString *)tag {
    if ([tag compare:TAG_CATEGORIES] == NSOrderedSame) {
        if ([delegateObject respondsToSelector:@selector(categoriesFetchDidFailWithError:)]) {
            [delegateObject categoriesFetchDidFailWithError:error];
        }
    }
}

- (void)manager:(VLBaseDataManager *)manager didSucceedWithObjects:(NSArray *)result requestTag:(NSString *)tag {
    /* The array objects are already of of type ProductCategory if the response is of this format (json or plist it don't matter cause you can change that when you built the request
     * [ { "CategoryID" : "1", "CategoryName" : "Shirts" }, { "CategoryID" : "2", "CategoryName" : "Blouses" }, { "CategoryID" : "3", "CategoryName" : "Boots" }]
     */
    if ([tag compare:TAG_CATEGORIES] == NSOrderedSame) {
        if ([delegateObject respondsToSelector:@selector(categoriesFetchDidSucceedWithData:)]) {
            [delegateObject categoriesFetchDidSucceedWithData:result];
        }
    }
}

@end
