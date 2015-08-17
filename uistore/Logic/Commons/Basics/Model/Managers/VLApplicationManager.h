//
//  ApplicationManager.h
//  flowers
//
//  Created  on 2/16/14.
//  Copyright (c) 2014  Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLApplicationManager : NSObject {
    @private
    // The name of the configuration file in the documents
    NSString* configurationFileName;
    
    // The dictionary that contains all the configuration values
    NSDictionary* configuration;
}

+ (VLApplicationManager*)sharedInstance;

// This method shall be called each time the applications starts to tell the manager to do whatever necessary
- (void)applicationStarted;

// This method tells if this is the first run of the app or not
- (BOOL)firstRun;

// This method stores a configuration by name and value
- (void)setData:(NSObject*)value forConfiguration:(NSString*)configKey;

// This method returns a dictionary of all the current app configuration
- (NSDictionary*)allConfiguration;

// This method returns the configuration value for the given key name
- (NSObject*)configurationForKey:(NSString*)configKey;

// This method generates the URL of the app on the App Store
- (NSString*)urlForAppWithID:(NSString*)appleAppID;

@end
