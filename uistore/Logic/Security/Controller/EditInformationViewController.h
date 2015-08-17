//
//  EditInformationViewController.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KBKeyboardHandlerDelegate.h"

@interface EditInformationViewController : UIViewController<UITextFieldDelegate, KBKeyboardHandlerDelegate>

@property (weak, nonatomic) IBOutlet UIButton* btnSave;

@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblEmail;

@property (weak, nonatomic) IBOutlet UITextField* txtName;
@property (weak, nonatomic) IBOutlet UITextField* txtEmail;

@end
