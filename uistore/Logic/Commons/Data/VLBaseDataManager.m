//
//  BaseManager.m
//  YAAB Library
//
//  Created  on 11/6/11.
//  Copyright 2011 YAAB. All rights reserved.
//

#import "VLBaseDataManager.h"

#import "VLDataConstants.h"

#import "VLPListParser.h"
#import "VLObjectParserProtocol.h"

@implementation VLBaseDataManager

- (NSArray*)loadDataFromFile:(NSString*)filePath
                 contentType:(NSString*)contentType
                   resultClass:(Class)resultType {
    // Parse the file content based on the content type (plist or json)
    NSArray* data = nil;
    if ([contentType compare:RESPONSE_PLIST] == NSOrderedSame) {
        data = [[VLPListParser sharedInstance] parsePListFile:filePath];
    }
    else
        if ([contentType compare:RESPONSE_JSON] == NSOrderedSame) {
            //TODO implement this one
        }
    
    // Parse the received data into objects
    NSMutableArray* items = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary* dict in data) {
        // Build the object of the
        NSObject* item = [[resultType alloc] init];
        
        // Parse the data
        [(NSObject<VLObjectParserProtocol>*)item parse:dict];
        
        // Add the item to the list
        [items addObject:item];
    }
    
    return items;
}

@end
