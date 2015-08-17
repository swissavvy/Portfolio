//
//  LoginViewController.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton* btnNormalLogin;
@property (weak, nonatomic) IBOutlet UIButton* btnFacebookLogin;
@property (weak, nonatomic) IBOutlet UIButton* btnRegister;
@property (weak, nonatomic) IBOutlet UILabel* lblCopyright;

@end
