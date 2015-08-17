//
//  PListParser.m
//  VIA Library
//
//  Created  on 1/4/13.
//  Copyright (c) 2013 VIA Technology International. All rights reserved.
//

#import "VLPListParser.h"

#import "VLFileManager.h"
#import "VLObjectParserProtocol.h"

@implementation VLPListParser

+ (VLPListParser*)sharedInstance {
    static VLPListParser* instance = nil;
    if (instance == nil) {
        instance = [[VLPListParser alloc] init];
    }
    
    return instance;
}

- (NSArray*)parsePListFile:(NSString*)filePath {
    // Try to parse an array and if it doesn't work, try to parse a dict and add it to array
    NSArray* result = [NSArray arrayWithContentsOfFile:filePath];
    if (result == nil) {
        // Try one dictionary
        NSDictionary* resultDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        result = @[resultDict];
    }
    
    return result;
}

- (NSArray*)parsePListData:(NSData*)data {
    // Get the temp file path
    NSString* tempFilePath = [[VLFileManager sharedInstance] filePathInTemp:@"PLISTPARSER_TEMP_FILE.plist"];
    [data writeToFile:tempFilePath atomically:NO];
    
    return [self parsePListFile:tempFilePath];
}

- (NSArray*)parsePListData:(NSData*)data toObject:(Class)objectType {
    // Parse the plist to an array of dictionaries
    NSArray* dictData = [self parsePListData:data];
    
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
