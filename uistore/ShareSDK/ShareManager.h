//
//  ShareManager.h
//  uistore
//
//  Created by Liu Jinyong on 15/7/17.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareManager : NSObject

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(ShareManager)

- (void)loginWithFacebook:(SSGetUserInfoEventHandler)result;

@end
