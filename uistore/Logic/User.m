//
//  User.m
//  uistore
//
//  Created by Liu Jinyong on 15/7/3.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import "User.h"

@implementation User

BD_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(User)

PROPERTY_OBJECT_USER_DEFAULT(ID, setID, @"id")
PROPERTY_OBJECT_USER_DEFAULT(userName, setUserName, @"userName")
PROPERTY_OBJECT_USER_DEFAULT(email, setEmail, @"email")

PROPERTY_BOOL_USER_DEFAULT(isLogin, setIsLogin, @"isLogin")

- (void)login:(NSDictionary *)dic {
    self.ID = dic[@"uid"];
    self.userName = dic[@"username"];
    if (dic[@"email"]) {
        self.email = dic[@"email"];
    }
    
    self.isLogin = YES;
}

- (void)logOut {
    self.isLogin = NO;
    self.ID = nil;
    self.userName = nil;
    self.email = nil;
}

@end
