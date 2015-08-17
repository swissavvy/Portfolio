//
//  FileManager.h
//  AT Library
//
//  Created  on 8/9/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

@interface VLFileManager : NSObject 

// Singelton method
+ (VLFileManager*) sharedInstance;

// This method returns the documents path for this application
- (NSString*) documentsPath;

// This method returns the path of the given file name in documents directory
- (NSString*) filePathInDocuments:(NSString*)fileName;

// This method returns the temporary directory path for this application
- (NSString*) tempPath;

// This method returns the path of the given file name in temp directory
- (NSString*)filePathInTemp:(NSString*)fileName;

// This method returns the cache folder path for this application
- (NSString*)cachePath;

// This method returns the path for the given file in the cache folder
- (NSString*)filePathInCache:(NSString*)fileName;

// This method returns the main bundle folder path for this application
- (NSString*)bundlePath;

// This method returns the path of the given file name in bundle directory
- (NSString*)filePathInBundle:(NSString*)fileName withExtention:(NSString*)type;

/*
 * This method returns the caches folder path for this application
 */
- (NSString*)cachesPath;

/*
 * This method checks if the given file exists
 */
- (BOOL)fileExits:(NSString*)path;

/*
 * This method deletes all files in the given path
 */
- (void)deleteFilesInPath:(NSString*)path;

/*
 * This method deletes the file in the given path
 */
- (void)deleteFile:(NSString*)path;

/*
 * This method deletes all the files that has the given extension in the given path
 */
- (void)deleteFilesWithExtension:(NSString*)extension inFolder:(NSString*)folderPath;

/*
 * This method copies all the files that has the given extension in the given source path to the given destination
 */
- (void)copyFilesWithExtension:(NSString*)extension fromFolder:(NSString*)sourcePath toFolder:(NSString*)destinationPath;

/*
 * This method creates the directory in the given path
 */
- (void)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates;

// This method copies a file from the source to the destination path
- (void)copyFileFrom:(NSString*)sourcePath to:(NSString*)destinationPath overWrite:(BOOL)overWrite;

/*
 * This method marks the file as non-purgeable and non-backed up
 */
- (void)addSkipBackupAttributeToFile:(NSString *)filePath;

@end
