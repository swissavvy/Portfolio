//
//  PListParser.h
//  VIA Library
//
//  Created  on 1/4/13.
//  Copyright (c) 2013 VIA Technology International. All rights reserved.
//



@interface VLPListParser : NSObject

+ (VLPListParser*)sharedInstance;

- (NSArray*)parsePListData:(NSData*)data;
- (NSArray*)parsePListFile:(NSString*)filePath;
- (NSArray*)parsePListData:(NSData*)data toObject:(Class)objectType;

@end
