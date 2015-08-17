//
//  CheckOutViewController.h
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cart;

@interface CheckOutViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    @private
    Cart* cart;
}

@property (weak, nonatomic) IBOutlet UILabel* lblName;
@property (weak, nonatomic) IBOutlet UILabel* lblConfirmation;

@property (weak, nonatomic) IBOutlet UITableView* tblItems;

@property (weak, nonatomic) IBOutlet UILabel* lblTotalPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblTotalPrice;

@property (weak, nonatomic) IBOutlet UILabel* lblShippingCostTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblShippingCost;

@property (weak, nonatomic) IBOutlet UIButton* btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton* btnCancel;

@property (weak, nonatomic) IBOutlet UILabel* lblItemsHeaderTitle;
@property (weak, nonatomic) IBOutlet UILabel* lblItemsHeaderQuantity;
@property (weak, nonatomic) IBOutlet UILabel* lblItemsHeaderPrice;

@end
