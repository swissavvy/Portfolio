//
//  NSErrorUtils.h
//  
//
//  Created  on 5/23/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLErrorUtils : NSObject

+ (VLErrorUtils*)sharedInstance;

- (NSError*)errorWithString:(NSString*)errorMessage;

@end
