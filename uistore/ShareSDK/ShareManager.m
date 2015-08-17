//
//  ShareManager.m
//  uistore
//
//  Created by Liu Jinyong on 15/7/17.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import "ShareManager.h"
#import <FacebookConnection/ISSFacebookApp.h>

@implementation ShareManager

BD_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(ShareManager)

- (id)init {
    if (self = [super init]) {
        [ShareSDK registerApp:@"9014d86ed366"];
        
        [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                                  appSecret:@"38053202e1a5fe26c80c753071f0b573"];
        
        
        //开启Facebook网页授权开关(optional)
        id<ISSFacebookApp> facebookApp =(id<ISSFacebookApp>)[ShareSDK getClientWithType:ShareTypeFacebook];
        [facebookApp setIsAllowWebAuthorize:YES];
    }
    return self;
}

- (void)loginWithFacebook:(SSGetUserInfoEventHandler)result {
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [authOptions setPowerByHidden:YES];
    
    [ShareSDK getUserInfoWithType:ShareTypeFacebook authOptions:authOptions result:^(BOOL isSuccess, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        result(isSuccess, userInfo, error);
    }];
//    [ShareSDK authWithType:ShareTypeFacebook options:authOptions result:^(SSAuthState state, id<ICMErrorInfo> error) {
//        result(state == SSAuthStateSuccess, nil, error);
//    }];
}

@end
