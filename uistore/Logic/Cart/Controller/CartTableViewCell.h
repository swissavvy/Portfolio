//
//  CartTableViewCell.h
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* imgProduct;
@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblSize;
@property (weak, nonatomic) IBOutlet UILabel* lblColour;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;
@property (weak, nonatomic) IBOutlet UILabel* lblQuantity;

@end
