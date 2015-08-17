//
//  Genre.m
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "Genre.h"

#import "ProductCategory.h"

#define GENRE_ID         @"GenreID"
#define GENRE_NAME       @"GenreName"
#define GENRE_CATEGORIES @"Categories"

@implementation Genre

+ (Genre*)menGenre {
    Genre* men = [[Genre alloc] initWithID:1];
    men.name = @"Men";
    return men;
}

+ (Genre*)womenGenre {
    Genre* women = [[Genre alloc] initWithID:2];
    women.name = @"Women";
    return women;
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
    
    self.ID = [dataDictionary[GENRE_ID] longLongValue];
    self.name = dataDictionary[GENRE_NAME];
    
    NSArray* categoriesDicts = dataDictionary[GENRE_CATEGORIES];
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:categoriesDicts.count];
    for (NSDictionary* categoryDict in categoriesDicts) {
        [result addObject:[[ProductCategory alloc] initWithDictionary:categoryDict]];
    }
    self.categories = result;
    
    return YES;
}

@end
