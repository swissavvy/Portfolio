//
//  NSErrorUtils.m
//  
//
//  Created  on 5/23/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "VLErrorUtils.h"

@implementation VLErrorUtils

+ (VLErrorUtils*)sharedInstance {
    static VLErrorUtils* instance = nil;
    if (instance == nil) {
        instance = [[VLErrorUtils alloc] init];
    }
    
    return instance;
}

- (NSError*)errorWithString:(NSString*)errorMessage {
    NSError* error = [[NSError alloc] initWithDomain:errorMessage
                                                code:-1
                                            userInfo:nil];
    return error;
}

@end
