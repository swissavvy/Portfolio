//
//  UITableView+BDAddition.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BDAddition)

- (void)deselectRow;
- (NSIndexPath *)indexPathForRowContainingView:(UIView *)view;

- (void)hideFooterSeparator;

@end