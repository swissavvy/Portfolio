//
//  NamedObject.m
//  AT Library
//
//  Created  on 7/27/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLNamedObject.h"

@implementation VLNamedObject

#define ONLINE_OBJECT_NAME @"Name"

- (id) initWithName:(NSString*)objectName {
    if (self = [super init]) {
        self.name = objectName;
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
    
    [super parse:dataDictionary];
    self.name = dataDictionary[ONLINE_OBJECT_NAME];
    
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ID: %lld, Name: %@", self.ID, self.name];
}

@end
