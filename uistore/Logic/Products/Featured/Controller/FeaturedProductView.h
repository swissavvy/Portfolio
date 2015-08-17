//
//  FeaturedProductView.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedProductView : UIView

@property (weak, nonatomic) IBOutlet UIImageView* imgProduct;
@property (weak, nonatomic) IBOutlet UILabel* lblTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblPrice;
@property (weak, nonatomic) IBOutlet UIButton* btnBuy;
@property (weak, nonatomic) IBOutlet UIView* titleView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
