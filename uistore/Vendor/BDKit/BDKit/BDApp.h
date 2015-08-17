//
//  AppInfo.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDApp : NSObject

+ (NSString *)bundleID;
+ (NSString *)bundleName;
+ (NSString *)bundleDisplayName;

+ (NSString *)appVersion;
+ (NSNumber *)buildVersion;

+ (NSString *)currentLanguage;
+ (NSString *)currentTimeZone;

+ (BOOL)isFirstLaunchInCurrentVersion;

// AppStore

+ (NSString *)reviewURI:(NSString *)appID;
+ (NSString *)downLoadURI:(NSString *)appID;
+ (NSString *)latesetVersionURI:(NSString *)appID;


@end