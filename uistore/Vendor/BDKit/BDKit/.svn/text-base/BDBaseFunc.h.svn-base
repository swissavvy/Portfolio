//
//  BDBaseFunc.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-26.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBaseFunc : NSObject

/*
 *  Swizz
 */
+ (void)swizzInstanceWithClass:(Class)clazz
              originalSelector:(SEL)originalSelector
                   newSelector:(SEL)newSelector;

+ (void)swizzClassWithClass:(Class)cls
           originalSelector:(SEL)originalSelector
                newSelector:(SEL)newSelector;

/*
 *  电话/短信/Email
 */
+ (BOOL)makeTelephoneCall:(NSString *)phoneNumber;
+ (BOOL)sendMessage:(NSString *)phoneNumber;
+ (BOOL)sendEmail:(NSString *)recipient subject:(NSString*)subject body:(NSString *)body;

/*
 *  动画
 */
+ (void)windowFadeAnimation;

/*
 *  杂项
 */
+ (BOOL)isExpired:(double)seconds key:(NSString *)key;

@end
