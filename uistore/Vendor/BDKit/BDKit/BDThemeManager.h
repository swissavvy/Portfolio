//
//  BDThemeManager.h
//  BDKit
//
//  Created by Liu Jinyong on 14-4-18.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDThemeUpdateProtocol.h"

// 每次主题改变时，发送通知(初始化除外)
extern NSString * const BDThemeManagerDidChangeThemes;

@interface BDThemeManager : NSObject

+ (BDThemeManager *)sharedInstance;

@property (nonatomic, strong, readonly) NSDictionary *styles;
@property (nonatomic, strong, readonly) NSString *currentThemeName;

- (int)intForKey:(NSString *)key;

// @{ @"labelFont" : @"Helvetica", @"labelFontSize" : @15 }
- (UIFont *)fontForKey:(NSString *)key;

- (UIColor *)colorForKey:(NSString *)key;

- (UIImage *)imageForKey:(NSString *)key;

- (NSString *)textForKey:(NSString *)key;

// 改变主题，参数不包含.plist扩展名
- (void)changeTheme:(NSString *)themeName;


- (void)addThemeObserver:(id<BDThemeUpdateProtocol>)observer;
- (void)removeThemeObserver:(id<BDThemeUpdateProtocol>)observer;

@end
