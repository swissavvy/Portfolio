//
//  Cart.h
//  uistore
//
//  Created  on 9/3/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cart : NSObject

@property (nonatomic) float totalPrice;

// Array of Product objects that are currently in the cart
@property (strong, nonatomic) NSMutableArray* items;

@end
