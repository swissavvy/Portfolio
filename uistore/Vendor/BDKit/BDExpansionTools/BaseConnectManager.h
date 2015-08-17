//
//  BaseConnectManager.h
//  BDKit
//
//  Created by Liu Jinyong on 13-9-11.
//  Copyright (c) 2013年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ConnectItem.h"

@interface BaseConnectManager : NSObject

+ (BaseConnectManager *)sharedManager;

- (ASIFormDataRequest *)connectURL:(NSString *)url
                              type:(ConnectType)type
                          delegate:(id)delegate
                               tag:(NSString *)tag
                          userInfo:(id)userInfo;

//供子类或类别实现的方法
- (void)handelRequestDidFinish:(ConnectItem *)connectItem
                         error:(NSError *)error;

//取消网络连接
- (void)cancelWithHashValue:(NSUInteger)itemHashValue;
- (void)cancelWithDelegate:(id)delegate;
- (void)cancelWithDelegate:(id)delegate tag:(NSString *)tag;
- (void)cancelWithURL:(NSString *)url
                 type:(ConnectType)type
               params:(NSDictionary *)params
             delegate:(id)del
                  tag:(NSString *)tag
             userInfo:(id)userInfo;

@end


@interface NSObject(BaseConnection)

- (void)requestDidFinishWithResponse:(NSString *)response
                                 tag:(NSString *)tag
                            userInfo:(id)userInfo
                             success:(BOOL)success;

@end

