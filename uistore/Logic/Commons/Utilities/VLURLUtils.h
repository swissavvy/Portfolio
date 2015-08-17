//
//  URLUtils.h
//  YAAB Library
//
//  Created  on 10/26/12.
//  Copyright (c) 2012 YAAB. All rights reserved.
//

@interface VLURLUtils : NSObject

+ (VLURLUtils*) sharedInstance;

// This method opens the given link in an external Safari app
- (void)openURLInSafari:(NSString*)url;

/*
 * Returns: A dictionary of all the variables names and their values from the given URL
 * It returns nil if the no variables were found or if the url is invalid
 */
- (NSDictionary*)variablesFromURL:(NSString*)url;

/* 
 * Returns: the value of the given QUERY STRING variable from the given URL
 * It returns nil if the variable doesn't exist or if the url is invalid
 */
- (NSString*)variableValue:(NSString*)name FromURL:(NSString*)url;

/*
 * This method changes the given youtube url to a valid youtube embed url in the below format
 * http://www.youtube.com/embed/youtube_video_id
 */
- (NSString*)youtubeEmbedUrl:(NSString*)url;

// This method returns an array with two items, the first one is the base url, the second one is the params part
- (NSArray*)twoPartURL:(NSString*)url;

// This method encodes the URL
- (NSString*)encodeURL:(NSString*)url;

@end
