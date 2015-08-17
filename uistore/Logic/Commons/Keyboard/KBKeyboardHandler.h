//
//  KBKeyboardHandler.h
//  
//
//  Created  on 6/10/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBKeyboardHandlerDelegate;

@interface KBKeyboardHandler : NSObject

- (id)init;

// Put 'weak' instead of 'assign' if you use ARC
@property(nonatomic, strong) id<KBKeyboardHandlerDelegate> delegate;
@property(nonatomic) CGRect frame;

@end