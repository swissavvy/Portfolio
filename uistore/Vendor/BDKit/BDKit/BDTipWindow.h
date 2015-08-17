//
//  BDTipWindow.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EventFail,
    EventSuccess,
    EventWarning
} EventType;

@interface BDTipWindow : UIWindow

+ (BDTipWindow *)sharedInstance;

- (void)showProgressHUDWithMessage:(NSString *)message;
- (void)showCompleteHUDWithMessage:(NSString *)message type:(EventType)type;
- (void)showCompleteHUDWithMessage:(NSString *)message image:(UIImage *)image;

- (void)hideProgressHUD;
- (void)hideProgressHUD:(BOOL)animated;

@end
