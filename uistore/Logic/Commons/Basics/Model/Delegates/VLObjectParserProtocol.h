//
//  ObjectParserProtocol.h
//  AT Library
//
//  Created  on 10/27/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

@class FMResultSet;

@protocol VLObjectParserProtocol <NSObject>

@optional

// Dictionary parsers
- (id)initWithDictionary:(NSDictionary*)dataDictionary;
- (BOOL)parse:(NSDictionary*)dataDictionary;

// Database parsers
- (id)initWithDBResult:(FMResultSet*)dbRow;
- (BOOL)parseFromDBResult:(FMResultSet*)dbRow;

@end
