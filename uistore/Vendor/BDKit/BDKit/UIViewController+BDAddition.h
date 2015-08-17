//
//  UIViewController+BDAddition.h
//  BDKit
//
//  Created by Liu Jinyong on 14-5-23.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BDAddition)

- (UIViewController *)pushViewControllerWithName:(NSString *)viewControllerName;
- (void)backBeforeViewController:(Class)aClass;

- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardWillShow:(NSNotification *)notification;

@end
