//
//  UIAlertView+Blocks.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockItem.h"

typedef void(^ActionBlock)();

@interface UIAlertView (Blocks)

+ (id)showWithTitle:(NSString *)title
            message:(NSString *)message
      confirmAction:(ActionBlock)action;

+ (id)showWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
       confirmTitle:(NSString *)confirmTitle
      confirmAction:(ActionBlock)action;

- (id)initWithTitle:(NSString *)inTitle
            message:(NSString *)inMessage
   cancelButtonItem:(BlockItem *)inCancelButtonItem
   otherButtonItems:(BlockItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(BlockItem *)item;

@end
