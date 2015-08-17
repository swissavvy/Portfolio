//
//  KBKeyboardHandlerDelegate.h
//  
//
//  Created  on 6/10/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBKeyboardHandlerDelegate <NSObject>

- (void)keyboardSizeChanged:(CGSize)delta;

@end
