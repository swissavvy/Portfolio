//
//  NSObject+BDAssociation.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BDAssociation)

- (id)associatedObjectForKey:(NSString*)key;
- (void)setAssociatedObject:(id)object forKey:(NSString*)key;

@end
