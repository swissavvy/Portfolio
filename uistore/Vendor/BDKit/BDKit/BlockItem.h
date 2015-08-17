//
//  BlockItem.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockItem : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, copy) void (^action)();

+ (BlockItem *)itemWithTitle:(NSString *)title;

@end

