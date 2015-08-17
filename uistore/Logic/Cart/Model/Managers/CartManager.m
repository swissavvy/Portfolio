//
//  CartManager.m
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CartManager.h"

#import "Cart.h"
#import "Product.h"

@implementation CartManager

+ (CartManager*)sharedInstnace {
    static CartManager* instance = nil;
    if (instance == nil) {
        instance = [[CartManager alloc] init];
    }
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
        cart = [[Cart alloc] init];
        cart.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (Cart*)currentCart {
    return cart;
}

- (Cart*)addProductToCart:(Product*)product {
    // Add the price of the product to the total price
    cart.totalPrice += (product.numericPrice * product.selectedQuantity);
    
    // Copy the passed product to avoid any problems
    Product* copiedProduct = [[Product alloc] initWithProduct:product];
    [cart.items insertObject:copiedProduct atIndex:cart.items.count];
    
    return [self currentCart];
}

- (Cart*)removeProductFromCartAtIndex:(int)index {
    Product* product = cart.items[index];
    cart.totalPrice -= (product.numericPrice * product.selectedQuantity);
    [cart.items removeObjectAtIndex:index];
    
    return [self currentCart];
}

- (Cart*)clearCart {
    [cart.items removeAllObjects];
    cart.totalPrice = 0;
    
    return [self currentCart];
}

@end
