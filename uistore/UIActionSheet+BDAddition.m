//
//  UIActionSheet+BDAddition.m
//  DNB
//
//  Created by Liu QQ:67111677 on 15/3/13.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "UIActionSheet+BDAddition.h"

@implementation UIActionSheet (BDAddition)

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray *)buttonTitles delegate:(id)delegate {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    for (NSString *buttonTitle in buttonTitles) {
        [sheet addButtonWithTitle:buttonTitle];
    }
    
    [sheet addButtonWithTitle:cancelTitle];
    sheet.cancelButtonIndex = sheet.numberOfButtons-1;
    
    return sheet;
}

@end
