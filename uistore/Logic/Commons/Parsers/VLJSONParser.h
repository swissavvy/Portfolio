//
//  JSONParser.h
//  VIA Library
//
//  Created  on 1/4/13.
//  Copyright (c) 2013 VIA Technology International. All rights reserved.
//

@interface VLJSONParser : NSObject

+ (VLJSONParser*)sharedInstance;

- (NSArray*)parseJSONData:(NSData*)data;
- (NSArray*)parseJSONData:(NSData*)data toObject:(Class)objectType;

@end
