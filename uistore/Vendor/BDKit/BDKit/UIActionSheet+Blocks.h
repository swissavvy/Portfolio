//
//  UIActionSheet+Blocks.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

- (id)initWithTitle:(NSString *)inTitle
   cancelButtonItem:(BlockItem *)inCancelButtonItem
destructiveButtonItem:(BlockItem *)inDestructiveItem
   otherButtonItems:(BlockItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(BlockItem *)item;

// This block is called when the action sheet is dismssed for any reason.
@property (copy, nonatomic) void(^dismissalAction)();

@end
