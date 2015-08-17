//
//  SignupViewController.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "RegisterViewController.h"

#import "KBKeyboardHandler.h"
#import "UIUtils.h"

#import "VLUser.h"

#import "ThemeManager.h"
#import "Theme.h"

@interface RegisterViewController () {
    UIView* signupView;
    BOOL viewBuilt;
    VLUser* userToRegister;
    KBKeyboardHandler* keyboardHandler;
}

@end

@implementation RegisterViewController

#pragma mark -
#pragma mark Keyboard Delegate

- (void)keyboardSizeChanged:(CGSize)delta {
    CGRect frame = self.view.frame;
    frame.origin.y -= (delta.height / 2);
    self.view.frame = frame;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (! viewBuilt) {
        // Create the view
        signupView = [[NSBundle mainBundle] loadNibNamed:@"SignupView" owner:self options:nil][0];
        [self.container addSubview:signupView];
        self.container.contentSize = CGSizeMake(signupView.frame.size.width, signupView.frame.size.height);
        
        // Apply Theming
        [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                           toView:self.btnSignup];
        
        [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                      toTextField:self.txtName];
        [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                      toTextField:self.txtEmail];
        [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                      toTextField:self.txtPassword];
        [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                      toTextField:self.txtConfirmPassword];
        
        // Apply custom font
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toTextField:self.txtName];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toTextField:self.txtEmail];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toTextField:self.txtPassword];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toTextField:self.txtConfirmPassword];
        
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                              toButton:self.btnSignup];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                              toButton:self.btnLogin];
        
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                               toLabel:self.lblHeader];
        [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                             accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                               toLabel:self.lblCopyrights];
        
        viewBuilt = YES;
        
        [self.view layoutIfNeeded];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the keyboard handler
    keyboardHandler = [[KBKeyboardHandler alloc] init];
    keyboardHandler.delegate = self;
}

#pragma mark -
#pragma mark Events

- (IBAction)btnLoginTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:@"registerLoginSegue" sender:self];
}

- (IBAction)signUpViewTapped:(id)sender {
    for (UIView* subView in signupView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView resignFirstResponder];
        }
    }
}

- (IBAction)btnRegisterTouchUpInside:(id)sender {
    NSString* name = self.txtName.text;
    NSString* email = self.txtEmail.text;
    NSString* password = self.txtPassword.text;
    NSString* confirmPassword = self.txtConfirmPassword.text;
    
    // Check if all the fields are filled
    BOOL allFilled = YES;
    allFilled = allFilled && (name != nil) && ([name compare:@""] != NSOrderedSame);
    allFilled = allFilled && (email != nil) && ([email compare:@""] != NSOrderedSame);
    allFilled = allFilled && (password != nil) && ([password compare:@""] != NSOrderedSame);
    allFilled = allFilled && (confirmPassword != nil) && ([confirmPassword compare:@""] != NSOrderedSame);
    if (! allFilled) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Required Fields"
                                                        message:@"Please fill all the fields to continue"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSDictionary *params = @{@"username": name,
                             @"email": email,
                             @"password": password};
    SHOW_LOADING;
    [[RequestManager manager] requestPostWithAction:@"api/user/register" parameters:params finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSDictionary *data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            [[User sharedInstance] login:data];
            [self performSegueWithIdentifier:@"successAutoLoginSegue" sender:self];
        }else {
            [Toast showText:msg];
        }
    }];
}

@end
