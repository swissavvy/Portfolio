//
//  BaseInternetManager.m
//  YAAB Library
//
//  Created  on 9/28/12.
//  Copyright (c) 2012 YAAB. All rights reserved.
//

#import "VLInternetManager.h"

#import "VLFileManager.h"
#import "VLErrorUtils.h"
#import "VLURLUtils.h"

#import "VLDataConstants.h"

#import "VLObjectParserProtocol.h"

@implementation VLInternetManager

/*
 * The response type is one of the below
 * JSON
 * PLIST
 * PLAIN
 * BINARY
 */
- (id)initWithType:(NSString*)responseType {
    self = [super init];
    if (self) {
        // Reset the data
        _dataSoFar = nil;
        
        _responseType = responseType;
    }
    
    return self;
}

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType {
    if (self = [self initWithType:responseType]) {
        _tempFileName = name;
        _url = url;
        self.delegate = delegate;
    }
    
    return self;
}

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
          startImmediately:(BOOL)immediately
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
              resultObject:(Class)resultObjectClass {
    if (self = [self initWithTempFileName:name url:url delegate:delegate responseType:responseType]) {
        _requestTag = tag;
        _resultClass = resultObjectClass;
        _requestMethod = VL_REQUEST_GET;
        if (immediately) {
            [self start];
        }
    }
    
    return self;
}

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass {
    if (self = [self initWithTempFileName:name url:url delegate:delegate responseType:responseType]) {
        _requestTag = tag;
        _resultClass = resultObjectClass;
        _requestMethod = method;
    }
    
    return self;
}

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass
            resultMetaData:(NSString*)metaData {
    if (self = [self initWithTempFileName:name
                                      url:url
                                 delegate:delegate
                             responseType:responseType
                               requestTag:tag
                            requestMethod:method
                             resultObject:resultObjectClass]) {
        _metaData = metaData;
    }
    
    return self;
}

- (id)initWithTempFileName:(NSString*)name
                       url:(NSString*)url
                  delegate:(id<VLDataDelegate>)delegate
              responseType:(NSString*)responseType
                requestTag:(NSString*)tag
             requestMethod:(NSString*)method
              resultObject:(Class)resultObjectClass
            resultMetaData:(NSString*)metaData
              cachedToFile:(NSString*)filePath {
    if (self = [self initWithTempFileName:name
                                      url:url
                                 delegate:delegate
                             responseType:responseType
                               requestTag:tag
                            requestMethod:method
                             resultObject:resultObjectClass
                           resultMetaData:metaData]) {
        _cacheFilePath = filePath;
    }
    
    return self;
}

#pragma mark -
#pragma mark Common Methods

- (void)start {
    lastProgress = 0.00f;

    if ([_requestMethod compare:VL_REQUEST_POST] == NSOrderedSame) {
        // Get the params from the URL and calculate the length
        NSArray* components = [[VLURLUtils sharedInstance] twoPartURL:_url];
        _url = components[0];
        if (components.count > 1) {
            _params = components[1];
            
            // Split the params again to get the body part only
            _params = [_params componentsSeparatedByString:@"="][1];
        }
    }

    // Build the rqeuest with the URL
    NSURL* url = [[NSURL alloc] initWithString:_url];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = _requestMethod;
    request.timeoutInterval = 15;
    
    // Add the required information for POST requests
    if ([_requestMethod compare:VL_REQUEST_POST] == NSOrderedSame) {
        // Convert the params to data and caluclate its length
        NSData* postData = [_params dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString* postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        // Fill HTTP header data (meta data)
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        // Fill HTTP body data (the request)
        [request setHTTPBody:postData];
    }
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self
                                                          startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [connection start];
}

#pragma mark -
#pragma Connection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    if (_dataSoFar == nil) {
        _dataSoFar = [[NSMutableData alloc] initWithData:data];
    }
    else {
        [_dataSoFar appendData:data];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate manager:self didFailWithError:error requestTag:_requestTag];
    _dataSoFar = nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection*)connection {
    
    
    
    // Get the temp file path
    NSString* tempFilePath = [[VLFileManager sharedInstance] filePathInTemp:_tempFileName];
    
    // Modify the data to avoid "null" values without " before and after it
    NSString* originalDataString = [[NSString alloc] initWithData:_dataSoFar encoding:NSUTF8StringEncoding];
    NSString* modifiedDataString = [originalDataString stringByReplacingOccurrencesOfString:@"null" withString:@"\"null\""];

    // Write the modified string to a file to load it after that
    [modifiedDataString writeToFile:tempFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (_cacheFilePath) {
        _stringDataToCache = modifiedDataString;
    }
    
    NSData* newData = [[NSData alloc] initWithContentsOfFile:tempFilePath];
    // If the data is JSON, parse it to PLIST first before writing it to the temp file
    if ([_responseType compare:RESPONSE_JSON] == NSOrderedSame) {
        NSError* error;
        [[NSJSONSerialization JSONObjectWithData:newData
                                         options:NSJSONReadingAllowFragments
                                           error:&error] writeToFile:tempFilePath atomically:YES];
        if (error != nil) {
            [self.delegate manager:self didFailWithError:error requestTag:_requestTag];
            _dataSoFar = nil;
            return;
        }
    }
    else if ([_responseType compare:RESPONSE_PLIST] == NSOrderedSame) {
        // Write the data to temp file
        [_dataSoFar writeToFile:tempFilePath atomically:YES];
    }
    else if ([_responseType compare:RESPONSE_PLAIN] == NSOrderedSame) {
        // Get the string of the NSData
        NSString* stringResult = [[NSString alloc] initWithData:_dataSoFar
                                                       encoding:NSUTF8StringEncoding];
        
        [self.delegate manager:self
         didSucceedWithObjects:[NSArray arrayWithObjects:stringResult, nil]
                    requestTag:_requestTag];
        
        // Write the file to the cache if required
        if (_cacheFilePath) {
            [_stringDataToCache writeToFile:_cacheFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        return;
    }
    else if ([_responseType compare:RESPONSE_BINARY] == NSOrderedSame) {
        // Write the file with the temp file name and send the name in the array to the requester
        [_dataSoFar writeToFile:tempFilePath atomically:YES];
        [self.delegate manager:self
         didSucceedWithObjects:[NSArray arrayWithObjects:tempFilePath, nil]
                    requestTag:_requestTag];
        
        // Write the file to the cache if required
        if (_cacheFilePath) {
            [_stringDataToCache writeToFile:_cacheFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        return;
    }
    
    // We'll reach here from JSON and PLIST only
    // Reload the data from .plist file to an array and then parse the array dicts to the object array
    NSMutableArray* objectsResult = [[NSMutableArray alloc] init];
    NSArray *result = [NSArray arrayWithContentsOfFile:tempFilePath];
    if (result == nil) {
        // Try one dictionary
        NSDictionary* resultDict = [NSDictionary dictionaryWithContentsOfFile:tempFilePath];
        if (resultDict == nil) {
            // Build the content to send with the error
            NSString* content = [[NSString alloc] initWithData:_dataSoFar encoding:NSUTF8StringEncoding];
            NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:content, @"json", nil];
            NSError* error = [NSError errorWithDomain:@"JSON Parsing Error, neither a valid array nor a valid dictionary"
                                                 code:-1
                                             userInfo:userInfo];
            
            [self.delegate manager:self didFailWithError:error requestTag:_requestTag];
            return;
        }
        
        result = @[resultDict];
    }
    
    if (result == nil) {
        NSError* error = [[VLErrorUtils sharedInstance] errorWithString:@"No data was found with the specified format"];
        [self.delegate manager:self didFailWithError:error requestTag:_requestTag];
    }
    else {
        // Write the file to the cache if required
        if (_cacheFilePath) {
            [_stringDataToCache writeToFile:_cacheFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        // Build the objects array if the objects class was provided
        if (_resultClass == nil) {
            // Send the dictionary data to the delegate
            [self.delegate manager:self didSucceedWithObjects:result requestTag:_requestTag];
        }
        else {
            // Send the parsed data to the delegate
            for (NSDictionary* dictItem in result) {
                NSObject* item = [[_resultClass alloc] init];
                if (_metaData != nil) {
                    [item setValue:_metaData forKey:@"dataName"];                
                }
                [(id<VLObjectParserProtocol>)item parse:dictItem];
                [objectsResult addObject:item];
            }
            
            [self.delegate manager:self didSucceedWithObjects:objectsResult requestTag:_requestTag];
        }
    }
}

@end
