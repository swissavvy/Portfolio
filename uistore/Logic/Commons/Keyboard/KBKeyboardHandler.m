//
//  KBKeyboardHandler.m
//  
//
//  Created  on 6/10/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

@interface KBKeyboardHandler() {
    CGRect previousTimeFrame;
}

@end

@implementation KBKeyboardHandler

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        //previousTimeFrame = CGRectMake(0, 0, 10, 10);
    }
    
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect oldFrame = self.frame;
    [self retrieveFrameFromNotification:notification];
    if (oldFrame.size.height != self.frame.size.height)
    {
        CGSize delta = CGSizeMake(self.frame.size.width - oldFrame.size.width,
                                  self.frame.size.height - oldFrame.size.height);
        if (self.delegate) {
            // Added by Aubada
            if ((previousTimeFrame.size.height > 0) && (delta.height > 0)) {
            
            }
            else {
                [self notifySizeChanged:delta notification:notification];
            }
        }
    }
    previousTimeFrame = self.frame;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.frame.size.height > 0.0)
    {
        [self retrieveFrameFromNotification:notification];
        CGSize delta = CGSizeMake(-self.frame.size.width, -self.frame.size.height);
        
        if (self.delegate)
            [self notifySizeChanged:delta notification:notification];
    }

    self.frame = CGRectZero;
    previousTimeFrame = self.frame;
}

- (void)retrieveFrameFromNotification:(NSNotification *)notification
{
    CGRect keyboardRect;
    [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
    self.frame = [[UIApplication sharedApplication].keyWindow.rootViewController.view convertRect:keyboardRect fromView:nil];
}

- (void)notifySizeChanged:(CGSize)delta notification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    
    UIViewAnimationCurve curve;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    NSTimeInterval duration;
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    void (^action)(void) = ^{
        [self.delegate keyboardSizeChanged:delta];
    };
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:curve
                     animations:action
                     completion:nil];
}

@end