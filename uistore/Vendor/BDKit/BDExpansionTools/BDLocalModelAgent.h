//
//  LocalModelAgent.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 BoDong BaiDu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDLocalModelAgent : NSObject

@property (nonatomic, copy) NSString *IDKey;    //默认是 @"ID"
@property (nonatomic, copy) NSString *domain;   //默认是ClassName
@property (nonatomic, assign) BOOL allowRepeat; //允许添加重复的ID 默认是NO

- (BOOL)isEmpty;

- (NSArray *)list;

- (BOOL)isExistID:(id)ID;   //根据 isEqual: 判断ID是否唯一

- (id)infoWithID:(NSString *)ID;

- (void)addInfoAtHead:(id)info;
- (void)addInfoAtTail:(id)info;

- (void)addInfos:(NSArray *)infos;

- (void)removeID:(id)ID;
- (void)removeInfo:(id)info;
- (void)removeInfoAtIndex:(int)index;

- (void)removeAllInfos;

- (void)saveInfos;

@end
