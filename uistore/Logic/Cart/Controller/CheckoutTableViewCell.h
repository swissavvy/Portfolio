//
//  CheckoutTableViewCell.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckoutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* lblTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;

@end
