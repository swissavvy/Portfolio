//
//  UIActionSheet+BDAddition.h
//  DNB
//
//  Created by Liu QQ:67111677 on 15/3/13.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (BDAddition)

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray *)titles delegate:(id)delegate;

@end
