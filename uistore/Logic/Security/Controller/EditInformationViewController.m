//
//  EditInformationViewController.m
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "EditInformationViewController.h"

#import "UserManager.h"
#import "VLUser.h"

#import "UIUtils.h"

#import "KBKeyboardHandler.h"

#import "ThemeManager.h"
#import "Theme.h"

@interface EditInformationViewController () {
    VLUser* currentUser;
    KBKeyboardHandler* keyboardHandler;
}

@end

@implementation EditInformationViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"Edit Information"
                               withTag:TAG_NAV_BAR_BACKGROUND];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the keyboard handler
    keyboardHandler = [[KBKeyboardHandler alloc] init];
    keyboardHandler.delegate = self;
    
    // Get the user's information
    currentUser = [[UserManager sharedInstance] currentUser];
    self.txtEmail.text = currentUser.email;
    self.txtName.text = currentUser.name;
    
    // Apply Theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtEmail];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtName];
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblName];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblEmail];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtName];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtEmail];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnSave];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.txtName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
}

#pragma mark -
#pragma mark Keyboard Handler

- (void)keyboardSizeChanged:(CGSize)delta {
    CGRect frame = self.btnSave.frame;
    frame.origin.y -= delta.height;
    self.btnSave.frame = frame;
}

#pragma mark -
#pragma mark Text Field Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [self.txtEmail becomeFirstResponder];
    }
    else if (textField == self.txtEmail) {
        [self.txtEmail resignFirstResponder];
    }
    
    return YES;
}

#pragma mark -
#pragma mark Events

- (IBAction)imgBackgroundTapped:(id)sender {
    [self.txtName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
}

- (IBAction)btnSaveTouchUpInside:(id)sender {
    NSString* newName = self.txtName.text;
    NSString* newEmail = self.txtEmail.text;
    
    // Check if any of the data is empty
    BOOL allFilled = YES;
    allFilled = allFilled && (newName != nil) && ([newName compare:@""] != NSOrderedSame);
    allFilled = allFilled && (newEmail != nil) && ([newEmail compare:@""] != NSOrderedSame);
    if (! allFilled) {
        UIAlertView* emptyField = [[UIAlertView alloc] initWithTitle:@"Data Error"
                                                             message:@"Please fill all the fields"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        [emptyField show];
    }
    else {
        // Store the information and send a confirmation to the user
        currentUser.email = newEmail;
        currentUser.name = newName;
        BOOL result = [[UserManager sharedInstance] updateUserInformation:currentUser];
        
        // Show a message based on the result
        NSString* messageTitle = @"Success";
        NSString* messageBody = @"Your information were successfully modified";
        if (! result) {
            messageTitle = @"Failure";
            messageBody = @"The email is already used, please try again";
        }
        
        UIAlertView* confirmation = [[UIAlertView alloc] initWithTitle:messageTitle
                                                               message:messageBody
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil, nil];
        [confirmation show];
    }
}

@end
