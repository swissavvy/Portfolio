//
//  UIView+BDTag.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

@interface UIView(BDTag)

@property (nonatomic, retain) NSString *tagString;
@property (nonatomic, retain) NSMutableArray *tagClasses;

- (UIView *)viewWithTagString:(NSString *)value;
- (UIView *)viewWithTagPath:(NSString *)value;

- (NSArray *)viewWithTagClass:(NSString *)value;
- (NSArray *)viewWithTagClasses:(NSArray *)array;

- (NSArray *)viewWithTagMatchRegex:(NSString *)regex;

@end
