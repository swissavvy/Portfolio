//
//  NumberedObject.m
//  AT Library
//
//  Created  on 9/29/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLNumberedObject.h"

#define ONLINE_OBJECT_ID @"ID"

@implementation VLNumberedObject

- (id) initWithID:(long)objectID {
    if (self = [super init]) {
        self.ID = objectID;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dataDictionary {
    if (self = [super init]) {
        [self parse:dataDictionary];
    }
    
    return self;
}

- (BOOL)parse:(NSDictionary*)dataDictionary {
    if (dataDictionary == nil) {
        return NO;
    }
    
    self.ID = [dataDictionary[ONLINE_OBJECT_ID] intValue];
    
    return YES;
}

@end
