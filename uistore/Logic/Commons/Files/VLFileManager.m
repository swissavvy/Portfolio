//
//  FileManager.m
//  AT Library
//
//  Created  on 8/9/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLFileManager.h"

#include <sys/xattr.h>

@implementation VLFileManager

+ (VLFileManager*)sharedInstance {
	static VLFileManager* instance = nil;
	if (instance == nil) {
		instance = [[VLFileManager alloc] init];
	}
	
	return instance;
}

/*
 * This method returns the documents path for this application (with / at the end)
 */
- (NSString*)documentsPath {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	// Build the documents path with /
	return [NSString stringWithFormat:@"%@/", [paths objectAtIndex:0]];
}

// This method returns the path of the given file name in documents
- (NSString*)filePathInDocuments:(NSString*)fileName {
    NSString* documentsPath = [self documentsPath];
    return [documentsPath stringByAppendingString:fileName];
}

// This method returns the temporary directory path for this application
- (NSString*)tempPath {
    return NSTemporaryDirectory();
}

// This method returns the path of the given file name in temp directory
- (NSString*)filePathInTemp:(NSString*)fileName {
    NSString* tempDirectory = NSTemporaryDirectory();
    return [tempDirectory stringByAppendingPathComponent:fileName];
}

// This method returns the cache folder path for this application
- (NSString*)cachePath {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

// This method returns the path for the given file in the cache folder
- (NSString*)filePathInCache:(NSString*)fileName {
    return [[self cachePath] stringByAppendingPathComponent:fileName];
}

// This method returns the main bundle folder path for this application
- (NSString*)bundlePath {
    return [[NSBundle mainBundle] bundlePath];
}

// This method returns the path of the given file name in bundle directory
- (NSString*)filePathInBundle:(NSString*)fileName withExtention:(NSString*)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

/*
 * This method returns the caches folder path for this application (with / at the end)
 */
- (NSString*)cachesPath {
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return [NSString stringWithFormat:@"%@/", [paths objectAtIndex:0]];
}

/*
 * This method checks if the given file exists
 */
- (BOOL)fileExits:(NSString*)path {
	BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:path];
	return result;
}

- (void)deleteFilesInPath:(NSString*)path {
    NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (int i = 0; i < [directoryContent count]; i++) {
        NSString* filePath = [path stringByAppendingPathComponent:[directoryContent objectAtIndex:i]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NO]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
        }
    }
}

- (void)deleteFile:(NSString*)path {
    if ( ([self fileExits:path]) && ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO]) ) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    }
}

/*
 * This method deletes all the files that has the given extension in the given path
 */
- (void)deleteFilesWithExtension:(NSString*)extension inFolder:(NSString*)folderPath {
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator* enumerator = [fileManager enumeratorAtPath:folderPath];
    
    for (NSString* fileName in enumerator) {
        // Get file path
        NSString* filePath = [folderPath stringByAppendingPathComponent:fileName];
        
        // Check the file extension
        if ([[[fileName pathExtension] lowercaseString] isEqualToString:[extension lowercaseString]]) {
            [[VLFileManager sharedInstance] deleteFile:filePath];
        }
    }
}

/*
 * This method copies all the files that has the given extension in the given source path to the given destination
 */
- (void)copyFilesWithExtension:(NSString*)extension fromFolder:(NSString*)sourcePath toFolder:(NSString*)destinationPath {
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    
    NSDirectoryEnumerator* enumerator = [fileManager enumeratorAtPath:sourcePath];

    for (NSString* fileName in enumerator) {
        // Find the file path at temp
        NSString* filePath = [sourcePath stringByAppendingPathComponent:fileName];
        // Check the file extension
        if ([[[filePath pathExtension] lowercaseString] isEqualToString:[extension lowercaseString]]) {
            // Move the file to the destination
            NSString* destinationFilePath = [destinationPath stringByAppendingPathComponent:fileName];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:destinationFilePath];
            if (fileExists) {
                [self deleteFile:destinationFilePath];
            }
            
            [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:destinationFilePath error:nil];
        }
    }
}

- (void)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates {
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:createIntermediates
                                               attributes:nil
                                                    error:nil];
}

- (void)copyFileFrom:(NSString*)sourcePath to:(NSString*)destinationPath overWrite:(BOOL)overWrite {
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:destinationPath];
    if ((fileExists) && (overWrite)) {
        [self deleteFile:destinationPath];
    }
    
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:nil];
}

/*
 * This method marks the file as non-purgeable and non-backed up
 */
- (void)addSkipBackupAttributeToFile:(NSString *)filePath {
	NSURL *fileURL = [NSURL fileURLWithPath:filePath];
	
	u_int8_t attributeValue = 1;
	setxattr([[fileURL path] fileSystemRepresentation], "com.apple.MobileBackup", &attributeValue, 1, 0, 0);
}


@end
