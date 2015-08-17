//
//  AppDelegate.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainSideMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (weak, nonatomic) MainSideMenuViewController* sideMenuController;

@property (strong, nonatomic) UIWindow *window;

@end
