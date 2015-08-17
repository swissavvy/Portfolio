//
//  SideMenuTableViewCell.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView* imgIcon;
@property (weak, nonatomic) IBOutlet UIView* viewBackground;

@end
