//
//  NSString+BDAddition.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

@interface NSString(BDAddition)

@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSDate *date;

@property (nonatomic, readonly) NSString *MD5;
@property (nonatomic, readonly) NSData *MD5Data;

@property (nonatomic, readonly) NSString *SHA1;

+ (NSString *)uuid;

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingArray:(NSArray *)params;
- (NSString *)urlByAppendingKeyValues:(id)first, ...;

- (NSString *)urlValueForKey:(NSString *)key;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSString *)queryStringFromArray:(NSArray *)array;
+ (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)trim;
- (NSString *)unwrap;

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsensitive:(BOOL)caseInsens;

- (BOOL)isTelephone;
- (BOOL)isUserName;
- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isWhitespaceAndNewlines;
- (BOOL)isLegal;    //是否仅含有数字、字母、下划线

- (BOOL)isMatchedByRegex:(NSString *)regex;

- (BOOL)isSubString:(NSString *)subString isCaseInsensitive:(BOOL)isCaseInsensitive;


@end

