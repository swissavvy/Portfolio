//
//  BDCacheProtocol.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import "BDCacheProtocol.h"

//该类需要JSONKit支持

@interface BDFileCache : NSObject<BDCacheProtocol>

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(BDFileCache);

@property (nonatomic, retain) NSString *cachePath;
@property (nonatomic, retain) NSString *cacheUser;

- (NSString *)fileNameForKey:(NSString *)key;

- (id)serialize:(id)obj;
- (id)unserialize:(id)data;

@end
