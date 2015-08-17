//
//  BaseInternetManager.h
//  YAAB Library
//
//  Created  on 9/28/12.
//  Copyright (c) 2012 YAAB. All rights reserved.
//

#import "VLBaseDataManager.h"

#import "VLDataDelegate.h"

@class VLDownloadItem;

@interface VLInternetManager : VLBaseDataManager<NSURLConnectionDelegate> {
    @private
    // This field represents the downloaded data so far
    NSMutableData* _dataSoFar;
    
    // Temp file name to store the result data in it and load it into an array
    NSString* _tempFileName;
    
    // This is the rest of the url to request (after the base url)
    NSString* _url;
    
    // This is the response type (JSON, PLIST, PLAIN or BINARY)
    NSString* _responseType;
    
    // This is the request tag that will be passed to the output as it's
    NSString* _requestTag;
    
    // This is the request http method to be used (GET or POST)
    NSString* _requestMethod;
    
    // This is the params part for the POST requests
    NSString* _params;
    
    // This is the class of the output objects and if it's provided, we parse the result objects to it
    Class _resultClass;
    
    // This is needed meta data for the result class obejct
    NSString* _metaData;
    
    // This is the cache file path, the original response is written to it if provided
    NSString* _cacheFilePath;
    NSString* _stringDataToCache;
    
    // This item contains the total, downloaded and remaining sizes of the item
    VLDownloadItem* downloadItem;
    // This is the last % progress (so we could know if we'll send a notification to the delegate)
    float lastProgress;
}

#pragma mark -
#pragma mark Init Methods

/*
 * The response type is one of the below
 * JSON
 * PLIST
 * PLAIN
 * BINARY
 */
- (id)initWithType:(NSString*)responseType;

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType;

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
          startImmediately:(BOOL)immediately
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
              resultObject:(Class)resultObjectClass;

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass;

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass
            resultMetaData:(NSString*)metaData;

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass
            resultMetaData:(NSString*)metaData
              cachedToFile:(NSString*)filePath;

- (void)start;

@end
