//
//  NSInvocation+BDConvenent.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSInvocation (BDConvenent)

+ (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector;
+ (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector argumentArray:(NSArray *)argumentArray;
+ (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector arguments:(id)obj, ...;

@end