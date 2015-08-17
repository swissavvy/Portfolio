//
//  ChangePasswordViewController.m
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "ChangePasswordViewController.h"

#import "VLUser.h"
#import "UserManager.h"

#import "UIUtils.h"

#import "ThemeManager.h"
#import "Theme.h"

#import "KBKeyboardHandler.h"

@interface ChangePasswordViewController () {
    KBKeyboardHandler* keyboardHandler;
    BOOL hideKeyboard;
    float oldHeight;
    BOOL previousConfirm;
}

@end

@implementation ChangePasswordViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set the bar image and text
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"Change Password"
                               withTag:TAG_NAV_BAR_BACKGROUND];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the keyboard
    keyboardHandler = [[KBKeyboardHandler alloc] init];
    keyboardHandler.delegate = self;
    
    // Apply Theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtOldPassword];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtNewPassword];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtConfirmPassword];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblOldPassword];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblNewPassword];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblConfirmPassword];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtOldPassword];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtNewPassword];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtConfirmPassword];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnChange];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.txtOldPassword resignFirstResponder];
    [self.txtNewPassword resignFirstResponder];
    [self.txtConfirmPassword resignFirstResponder];
}

#pragma mark -
#pragma mark Keyboard Delegate

- (void)keyboardSizeChanged:(CGSize)delta {
    if (delta.height < 0) {
        oldHeight = 0;
    }
    else {
        oldHeight = delta.height;
    }
    
    if (([self.txtConfirmPassword isFirstResponder]) || (hideKeyboard)) {
        CGRect frame = self.view.frame;
        frame.origin.y -= (delta.height / 2);
        self.view.frame = frame;
        
        frame = self.btnChange.frame;
        frame.origin.y -= (delta.height / 2);
        self.btnChange.frame = frame;
        
        hideKeyboard = ! hideKeyboard;
    }
}

#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.txtConfirmPassword) {
        CGRect frame = self.view.frame;
        frame.origin.y -= (oldHeight / 2);
        self.view.frame = frame;
        
        frame = self.btnChange.frame;
        frame.origin.y -= (oldHeight / 2);
        self.btnChange.frame = frame;

        previousConfirm = YES;
    }
    else {
        if (previousConfirm) {
            CGRect frame = self.view.frame;
            frame.origin.y += (oldHeight / 2);
            self.view.frame = frame;
            
            frame = self.btnChange.frame;
            frame.origin.y += (oldHeight / 2);
            self.btnChange.frame = frame;
        }
        
        previousConfirm = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtOldPassword) {
        [self.txtNewPassword becomeFirstResponder];
    }
    else if (textField == self.txtNewPassword) {
        [self.txtConfirmPassword becomeFirstResponder];
    }
    else if (textField == self.txtConfirmPassword) {
        [self.txtConfirmPassword resignFirstResponder];
    }
    
    return YES;
}

#pragma mark -
#pragma mark Events

- (IBAction)btnChangeTouchUpInside:(id)sender {
    NSString* oldPassword = self.txtOldPassword.text;
    NSString* newPassword = self.txtNewPassword.text;
    NSString* confirmPasssword = self.txtConfirmPassword.text;
    
    BOOL allFilled = YES;
    allFilled = ((oldPassword != nil) && ([oldPassword compare:@""] != NSOrderedSame));
    allFilled = ((newPassword != nil) && ([newPassword compare:@""] != NSOrderedSame));
    allFilled = ((confirmPasssword != nil) && ([confirmPasssword compare:@""] != NSOrderedSame));
    if (! allFilled) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Empty Fields"
                                                        message:@"Please fill all the fields to continue"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        // Check if the new password and its confirmation match
        if (! [newPassword compare:confirmPasssword] == NSOrderedSame) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"New Password Error"
                                                            message:@"The new password and its confirmation don't match"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            // Try to change the password
            BOOL result = [[UserManager sharedInstance] changeCurrentUserPasswordFrom:oldPassword to:newPassword];
            if (! result) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Old Password Problem"
                                                                message:@"Your old password is not correct, please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:@"The password was changed successfully, please log in again"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (IBAction)imgBackgroundTapped:(id)sender {
    [self.txtOldPassword resignFirstResponder];
    [self.txtNewPassword resignFirstResponder];
    [self.txtConfirmPassword resignFirstResponder];
}

#pragma mark -
#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[User sharedInstance] logOut];
    
    // Redirect the user to the login page
    [self performSegueWithIdentifier:@"changePasswordSuccessSegue" sender:self];
}

@end
