//
//  SignupViewController.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBKeyboardHandlerDelegate.h"

@interface RegisterViewController : UIViewController<KBKeyboardHandlerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView* container;

@property (weak, nonatomic) IBOutlet UITextField* txtName;
@property (weak, nonatomic) IBOutlet UITextField* txtEmail;
@property (weak, nonatomic) IBOutlet UITextField* txtPassword;
@property (weak, nonatomic) IBOutlet UITextField* txtConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton* btnSignup;
@property (weak, nonatomic) IBOutlet UIButton* btnLogin;

@property (weak, nonatomic) IBOutlet UILabel* lblHeader;
@property (weak, nonatomic) IBOutlet UILabel* lblCopyrights;

@end
