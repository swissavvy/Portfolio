//
//  ProductCollectionViewCell.h
//  uistore
//
//  Created  on 8/27/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductGridView : UIView

@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView* imgProduct;
@property (weak, nonatomic) IBOutlet UIView* titleView;

@end
