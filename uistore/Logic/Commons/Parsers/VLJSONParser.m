//
//  JSONParser.m
//  VIA Library
//
//  Created  on 1/4/13.
//  Copyright (c) 2013 VIA Technology International. All rights reserved.
//

#import "VLJSONParser.h"

#import "VLPListParser.h"
#import "VLFileManager.h"
#import "VLObjectParserProtocol.h"

@implementation VLJSONParser

+ (VLJSONParser*)sharedInstance {
    static VLJSONParser* instance = nil;
    if (instance == nil) {
        instance = [[VLJSONParser alloc] init];
    }

    return instance;
}

- (NSArray*)parseJSONData:(NSData*)data {
    // Get the temp file path
    NSString* tempFilePath = [[VLFileManager sharedInstance] filePathInTemp:@"TEMPFILE"];
    NSError* error;
    [[NSJSONSerialization JSONObjectWithData:data
                                     options:0
                                       error:&error] writeToFile:tempFilePath atomically:YES];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }

    // Parse the result
    NSArray* result = [[VLPListParser sharedInstance] parsePListFile:tempFilePath];
    
    // Remove the temp file
    [[VLFileManager sharedInstance] deleteFile:tempFilePath];
    
    return result;
}

- (NSArray*)parseJSONData:(NSData*)data toObject:(Class)objectType {
    // Parse the json to an array of dictionaries
    NSArray* dictData = [self parseJSONData:data];
    
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:dictData.count];
    // Parse the dictionaries to an array of the given object type
    for (NSDictionary* dictItem in dictData) {
        NSObject* item = [[objectType alloc] init];
        [(id<VLObjectParserProtocol>)item parse:dictItem];
        [result addObject:item];
    }
    
    return result;
}

@end
