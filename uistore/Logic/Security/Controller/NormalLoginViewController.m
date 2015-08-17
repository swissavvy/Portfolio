//
//  NormalLoginViewController.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "NormalLoginViewController.h"

#import "UIUtils.h"

#import "VLUser.h"

#import "KBKeyboardHandler.h"

#import "ThemeManager.h"
#import "Theme.h"

@interface NormalLoginViewController () {
    KBKeyboardHandler* keyboardHandler;
}

@end

@implementation NormalLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide the navigation bar
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set keyboard data
    keyboardHandler = [[KBKeyboardHandler alloc] init];
    keyboardHandler.delegate = self;
    
    // Apply theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnLogin];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtUsername];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                  toTextField:self.txtPassword];
    
    // Apply custom font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtUsername];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                       toTextField:self.txtPassword];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnLogin];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                          toButton:self.btnForgotPassword];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnRegister];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:self.lblCopyrights];
}

#pragma mark -
#pragma mark Events

- (IBAction)backgroundTapped:(id)sender {
    [self.txtUsername resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

- (IBAction)btnLoginTouchUpInside:(id)sender {
    NSString* username = self.txtUsername.text;
    NSString* password = self.txtPassword.text;
    
    BOOL allFilled = YES;
    allFilled = allFilled && (username != nil) && ([username compare:@""] != NSOrderedSame);
    allFilled = allFilled && (password != nil) && ([password compare:@""] != NSOrderedSame);
    
    if (! allFilled) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing Data"
                                                        message:@"Please enter both email and password"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSDictionary *params = @{@"identity" : username,
                             @"password" : password};
    
    SHOW_LOADING;
    [[RequestManager manager] requestPostWithAction:@"api/user/login" parameters:params finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSDictionary *data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            [[User sharedInstance] login:data];
            
            [self performSegueWithIdentifier:@"successfulLoginSegue" sender:self];
        }else {
            [Toast showText:msg];
        }
    }];
}

#pragma mark -
#pragma mark Keyboard Delegate

- (void)keyboardSizeChanged:(CGSize)delta {
    CGRect frame = self.view.frame;
    frame.origin.y -= (delta.height / 2);
    self.view.frame = frame;
}

#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
