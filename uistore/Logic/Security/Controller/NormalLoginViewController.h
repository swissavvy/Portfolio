//
//  NormalLoginViewController.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBKeyboardHandlerDelegate.h"

@interface NormalLoginViewController : UIViewController<KBKeyboardHandlerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField* txtUsername;
@property (weak, nonatomic) IBOutlet UITextField* txtPassword;

@property (weak, nonatomic) IBOutlet UIButton* btnLogin;
@property (weak, nonatomic) IBOutlet UIButton* btnRegister;
@property (weak, nonatomic) IBOutlet UIButton* btnForgotPassword;

@property (weak, nonatomic) IBOutlet UILabel* lblCopyrights;

@end
