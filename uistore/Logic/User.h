//
//  User.h
//  uistore
//
//  Created by Liu Jinyong on 15/7/3.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

BD_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(User)

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) NSString *ID;
@property (nonatomic, assign) NSString *userName;
@property (nonatomic, assign) NSString *email;

- (void)login:(NSDictionary *)dic;
- (void)logOut;

@end
