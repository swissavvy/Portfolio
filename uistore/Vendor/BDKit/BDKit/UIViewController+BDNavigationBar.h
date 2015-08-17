//
//  UIViewController+BDNavigationBar.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BDNavigationBar)

+ (void)setNavigationButtonTitleColor:(UIColor *)color;

+ (void)hideBackButtonTitle;

- (UIButton *)setNavigationButtonWithImgName:(NSString *)imgName
                        highlightedImageName:(NSString *)highlightedImageName
                                      action:(SEL)action
                                      isLeft:(BOOL)isLeft
                             autoEdgeInserts:(BOOL)autoEdgeInserts;

- (UIButton *)setNavigationButtonWithTitle:(NSString *)title
                                    action:(SEL)action
                                    isLeft:(BOOL)isLeft
                           autoEdgeInserts:(BOOL)autoEdgeInserts;

- (void)backToPreviousViewController;    // pop or dismiss self
- (void)backBeforeViewController:(Class)aClass;

@end