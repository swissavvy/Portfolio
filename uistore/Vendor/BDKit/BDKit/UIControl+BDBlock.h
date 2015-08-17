//
//  UIControl+BDBlock.h
//  BDKit
//
//  Created by Liu Jinyong on 14-6-26.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (BDBlock)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;

@end
