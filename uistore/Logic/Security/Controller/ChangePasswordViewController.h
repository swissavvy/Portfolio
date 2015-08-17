//
//  ChangePasswordViewController.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBKeyboardHandlerDelegate.h"

@interface ChangePasswordViewController : UIViewController<KBKeyboardHandlerDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel* lblOldPassword;
@property (weak, nonatomic) IBOutlet UILabel* lblNewPassword;
@property (weak, nonatomic) IBOutlet UILabel* lblConfirmPassword;

@property (weak, nonatomic) IBOutlet UITextField* txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField* txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField* txtConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton* btnChange;

@end
