//
//  ProductTableViewCell.h
//  uistore
//
//  Created  on 8/27/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView* imgProduct;

@end
