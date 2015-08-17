//
//  ManagerDelegate.h
//  YAAB Library
//
//  Created  on 4/28/2011.
//  Copyright 2011 YAAB. All rights reserved.
//

@class VLBaseDataManager;

@class VLDownloadItem;

@protocol VLDataDelegate <NSObject>

@required

- (void)manager:(VLBaseDataManager*)manager didSucceedWithObjects:(NSArray*)result requestTag:(NSString*)tag;

- (void)manager:(VLBaseDataManager*)manager didFailWithError:(NSError*)error requestTag:(NSString*)tag;

@optional

- (void)manager:(VLBaseDataManager*)manager didProgressInDownloadItem:(VLDownloadItem*)item requestTag:(NSString*)tag;

@end
