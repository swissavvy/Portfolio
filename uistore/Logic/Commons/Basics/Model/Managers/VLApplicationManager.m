//
//  ApplicationManager.m
//  flowers
//
//  Created  on 2/16/14.
//  Copyright (c) 2014  Inc. All rights reserved.
//

#import "VLApplicationManager.h"

#import "VLAppConstants.h"
#import "VLFileManager.h"
#import "VLPListParser.h"

@interface VLApplicationManager()

// This method rewrites the configuration to the file
- (void)updateConfiguration:(NSDictionary*)newConfiguration;

// This method loads all the configuration from the file to the memory
- (void)loadConfiguration;

// This method returns the current visit number for further checking
- (NSNumber*)currentVisitNumber;

// This method returns the path for the configuration file
- (NSString*)filePath;

@end

@implementation VLApplicationManager

+ (VLApplicationManager*)sharedInstance {
    static VLApplicationManager* instance = nil;
    if (instance == nil) {
        instance = [[VLApplicationManager alloc] init];
        [instance loadConfiguration];
    }
    
    return instance;
}

- (void)applicationStarted {
    // Get the current visist number
    int currentVisistNumber = [[self currentVisitNumber] intValue];
    
    // Change the configuration for first visit number
    NSMutableDictionary* newConfiguration = [[NSMutableDictionary alloc] initWithDictionary:configuration];
    newConfiguration[VL_APP_CONFIG_VISIT_NUMBER] = [NSNumber numberWithInt:currentVisistNumber + 1];
    
    // Update the configuration file
    [self updateConfiguration:newConfiguration];
    
    // Set the  basic configuration if this is the first run of the app
    if ([self firstRun]) {
        // Set font size to normal
        newConfiguration[VL_APP_CONFIG_FONT_SIZE] = [NSNumber numberWithFloat:VL_APP_CONFIG_FONT_SIZE_NORMAL];
        
        // Update the configuration on the device and in the memory
        [self updateConfiguration:newConfiguration];
    }
}

- (BOOL)firstRun {
    // Get the current visit number
    int currentVisistNumber = [[self currentVisitNumber] intValue];
    return (currentVisistNumber == 1);
}

// This method stores a configuration by name and value
- (void)setData:(NSObject*)value forConfiguration:(NSString*)configKey {
    // Update the configuraiton in memory with the new data
    NSMutableDictionary* newConfiguration = [[NSMutableDictionary alloc] initWithDictionary:configuration];
    newConfiguration[configKey] = value;
    
    // Update the configuration file
    [self updateConfiguration:newConfiguration];
}

// This method returns a dictionary of all the current app configuration
- (NSDictionary*)allConfiguration {
    return configuration;
}

// This method returns the configuration value for the given key name
- (NSObject*)configurationForKey:(NSString*)configKey {
    return configuration[configKey];
}

- (NSString*)urlForAppWithID:(NSString*)appleAppID {
    return [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", appleAppID];
}

#pragma mark -
#pragma mark Private Methods

// This method loads all the configuration from the file to the memory
- (void)loadConfiguration {
    // Get file path in documents
    NSString* filePath = [self filePath];
    
    // Check if the file exists
    if ([[VLFileManager sharedInstance] fileExits:filePath]) {
        // Load the configuration to the dictionary
        configuration = [[VLPListParser sharedInstance] parsePListFile:filePath][0];
    }
    else {
        // Write a new file with the required configuration
        NSMutableDictionary* configurationToWrite = [[NSMutableDictionary alloc] init];
        configurationToWrite[VL_APP_CONFIG_VISIT_NUMBER] = [NSNumber numberWithInt:0];
        
        // Write the configuration to the file
        [configurationToWrite writeToFile:filePath atomically:YES];
        configuration = configurationToWrite;
    }
}

// This method rewrites the configuration to the file
- (void)updateConfiguration:(NSDictionary*)newConfiguration {
    // Get file path in documents
    NSString* filePath = [self filePath];
    
    // Write the configuration to the file
    [newConfiguration writeToFile:filePath atomically:YES];
    
    // Reload the new configuration to the memory
    [self loadConfiguration];
}

// This method returns the current visit number for further checking
- (NSNumber*)currentVisitNumber {
    return configuration[VL_APP_CONFIG_VISIT_NUMBER];
}

// This method returns the path for the configuration file
- (NSString*)filePath {
    return[[VLFileManager sharedInstance] filePathInDocuments:@"app_config"];
}

@end
