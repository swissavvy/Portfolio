//
//  BDMemoryCache.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

@interface BDMemoryCache : NSObject<BDCacheProtocol>

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(BDMemoryCache);

@property (nonatomic, assign) BOOL					clearWhenMemoryLow;
@property (nonatomic, assign) NSUInteger			maxCacheCount;
@property (nonatomic, assign) NSUInteger			cachedCount;
@property (nonatomic, retain) NSMutableArray *		cacheKeys;
@property (nonatomic, retain) NSMutableDictionary *	cacheObjs;

@end
