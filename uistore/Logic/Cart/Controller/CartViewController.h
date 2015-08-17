//
//  CartViewController.h
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cart;

@interface CartViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    @private
    Cart* cart;
}

@property (weak, nonatomic) IBOutlet UILabel* lblTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel* lblTotalCount;
@property (weak, nonatomic) IBOutlet UILabel* lblTotalCountUnit;

@property (weak, nonatomic) IBOutlet UITableView* tblItems;

@property (weak, nonatomic) IBOutlet UIButton* btnCheckout;
@property (weak, nonatomic) IBOutlet UIButton* btnClear;

@end
