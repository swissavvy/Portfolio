//
//  CartManager.h
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cart;
@class Product;

@interface CartManager : NSObject {
    @private
    Cart* cart;
}

+ (CartManager*)sharedInstnace;

- (Cart*)currentCart;
- (Cart*)addProductToCart:(Product*)product;
- (Cart*)removeProductFromCartAtIndex:(int)index;
- (Cart*)clearCart;

@end
