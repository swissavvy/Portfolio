//
//  AccountViewController.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel* lblNameTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblEmailTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblPasswordTitle;

@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblEmail;
@property (weak, nonatomic) IBOutlet UILabel* lblPassword;

@property (weak, nonatomic) IBOutlet UIButton* btnEditInformation;
@property (weak, nonatomic) IBOutlet UIButton* btnChangePassword;

@end
