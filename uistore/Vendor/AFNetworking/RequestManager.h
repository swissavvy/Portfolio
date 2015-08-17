//
//  RequestManager.h
//  uistore
//
//  Created by Liu Jinyong on 15/7/3.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

@interface RequestManager : AFHTTPRequestOperationManager

- (AFHTTPRequestOperation *)requestPostWithAction:(NSString *)action
                                   parameters:(NSDictionary *)parameters
                                       finish:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg))finish;



- (AFHTTPRequestOperation *)requestGetWithAction:(NSString *)action
                                      parameters:(NSDictionary *)parameters
                                          finish:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg))finish;
@end
