//
//  BDInterapp.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 结构与CLLocationCoordinate2D相同，仅为去除对CoreLocation库的依赖
typedef struct {
	double latitude;
	double longitude;
} BDLocationCoordinate2D;


@class BDMailAppInvocation;


@interface BDInterApp : NSObject

#pragma mark Chrome vs Safari

+ (void)setPreferGoogleChrome:(BOOL)preferGoogleChromeOverSafari;
+ (BOOL)preferGoogleChrome;
+ (BOOL)openPreferredBrowserWithURL:(NSURL *)url;

#pragma mark Safari

+ (BOOL)safariWithURL:(NSURL *)url;

#pragma mark Google Chrome

+ (BOOL)googleChromeIsInstalled;
+ (BOOL)googleChromeWithURL:(NSURL *)url;
+ (NSString *)googleChromeAppStoreId;

#pragma mark Google Maps

+ (BOOL)googleMapsIsInstalled;
+ (BOOL)googleMaps;
+ (NSString *)googleMapsAppStoreId;

+ (BOOL)googleMapAtLocation:(BDLocationCoordinate2D)location;
+ (BOOL)googleMapAtLocation: (BDLocationCoordinate2D)location title: (NSString *)title;
+ (BOOL)googleMapDirectionsFromLocation: (BDLocationCoordinate2D)fromLocation toLocation: (BDLocationCoordinate2D)toLocation;

// directionsMode 可以为: nil. @"driving", @"transit", or @"walking".
+ (BOOL)googleMapDirectionsFromLocation: (BDLocationCoordinate2D)fromLocation toLocation: (BDLocationCoordinate2D)toLocation withMode:(NSString*)directionsMode;
+ (BOOL)googleMapDirectionsFromSourceAddress: (NSString*)srcAddr toDestAddress: (NSString*)destAddr withMode:(NSString*)directionsMode;

// 使用用户当前的location
+ (BOOL)googleMapDirectionsToDestAddress: (NSString*)destAddr withMode:(NSString*)directionsMode;
+ (BOOL)googleMapDirectionsToLocation: (BDLocationCoordinate2D)toLocation withMode:(NSString*)directionsMode;

#pragma mark Phone

+ (BOOL)phone;
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber;

#pragma mark SMS

+ (BOOL)sms;
+ (BOOL)smsWithNumber:(NSString *)phoneNumber;

#pragma mark Mail

+ (BOOL)mailWithInvocation:(BDMailAppInvocation *)invocation;

#pragma mark App Store

+ (BOOL)appStoreWithAppId:(NSString *)appId;
+ (BOOL)appStoreGiftWithAppId:(NSString *)appId;
+ (BOOL)appStoreReviewWithAppId:(NSString *)appId;

#pragma mark Custom Application

+ (BOOL)applicationIsInstalledWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andAppStoreId:(NSString *)appStoreId;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andPath:(NSString *)path;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme appStoreId:(NSString *)appStoreId andPath:(NSString *)path;

@end

@interface BDMailAppInvocation : NSObject

@property (nonatomic, copy) NSString *recipient;
@property (nonatomic, copy) NSString *cc;
@property (nonatomic, copy) NSString *bcc;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;

@end
