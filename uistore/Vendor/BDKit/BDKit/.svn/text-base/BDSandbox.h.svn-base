//
//  BDSandbox.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//


#pragma mark -

@interface BDSandbox : NSObject

+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容


+ (NSString *)fileNameFromeURL:(NSString *)url;
+ (BOOL)createFolderIfNeedWithPath:(NSString *)path;
+ (BOOL)deleteFileWithPath:(NSString *)path;
+ (float)getFileSize:(NSString *)filePath;


@end
