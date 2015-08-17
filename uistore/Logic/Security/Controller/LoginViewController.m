//
//  LoginViewController.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "LoginViewController.h"
#import "ShareManager.h"
#import "ThemeManager.h"
#import "Theme.h"
#import "RequestManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark -
#pragma mark Controller Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Log the user out
//    [[UserManager sharedInstance] logOut];
    // Hide the navigation bar
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Apply Theming
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnNormalLogin];
    [[ThemeManager sharedInstance] applyTheme:[[ThemeManager sharedInstance] roundedViewTheme]
                                       toView:self.btnFacebookLogin];
    
    // Apply Custom font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnFacebookLogin];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnNormalLogin];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                          toButton:self.btnRegister];
    
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:self.lblCopyright];
}

- (IBAction)loginWithFacebook:(id)sender {
    [[ShareManager sharedInstance] loginWithFacebook:^(BOOL isSuccess, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (isSuccess) {
            SHOW_LOADING;
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setKey:@"username" object:userInfo.nickname];
//            [params setKey:@"email" object:userInfo.email];
            [params setKey:@"oauth_client" object:userInfo.credential.token];
            [params setKey:@"oauth_client_user_id" object:userInfo.uid];
            
            [[RequestManager manager] requestPostWithAction:@"api/user/oauth-login" parameters:params finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSDictionary *data, NSString *msg) {
                HIDE_HUD;
                if (isSuccess) {
                    [[User sharedInstance] login:data];
                    
                    [self performSegueWithIdentifier:@"successfulLoginSegue" sender:self];
                }else {
                    [Toast showText:msg];
                }
            }];
        }else {
            [Toast showText:[error errorDescription]];
        }
    }];
}

@end
