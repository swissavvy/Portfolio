//
//  UIViewController+BDPopupViewController.h
//  BDModalViewController
//
//  Created by Martin Juhasz on 11.05.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDPopupBackgroundView;

typedef enum {
    BDPopupViewAnimationNone = -1,
    BDPopupViewAnimationFade = 0,
    BDPopupViewAnimationSlideBottomTop = 1,
    BDPopupViewAnimationSlideBottomBottom,
    BDPopupViewAnimationSlideTopTop,
    BDPopupViewAnimationSlideTopBottom,
    BDPopupViewAnimationSlideLeftLeft,
    BDPopupViewAnimationSlideLeftRight,
    BDPopupViewAnimationSlideRightLeft,
    BDPopupViewAnimationSlideRightRight,
} BDPopupViewAnimation;

@interface UIViewController (BDPopupViewController)

@property (nonatomic, retain) UIViewController *bdPopupViewController;
@property (nonatomic, retain) BDPopupBackgroundView *bdPopupBackgroundView;

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(BDPopupViewAnimation)animationType;

- (void)presentPopupViewController:(UIViewController*)popupViewController
                     animationType:(BDPopupViewAnimation)animationType
               enableDismissButton:(BOOL)enableDismissButton
                         dismissed:(void(^)(void))dismissed;

- (void)dismissPopupViewControllerWithanimationType:(BDPopupViewAnimation)animationType;

@end
