//
//  RequestManager.m
//  uistore
//
//  Created by Liu Jinyong on 15/7/3.
//  Copyright (c) 2015年 Enma Solutions. All rights reserved.
//

#import "RequestManager.h"

#define SK @"3bd08b5d969e45"

@implementation RequestManager

- (AFHTTPRequestOperation *)requestPostWithAction:(NSString *)action
                                       parameters:(NSDictionary *)parameters
                                           finish:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg))finish {
    NSString *url = FORMAT(@"%@%@", SERVICE_URL, action);
    
    BDLogInfo(@"%@", url);
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [postParameters setObject:[self getSNWithDic:parameters] forKey:@"sn"];
    
    BDLogInfo(@"%@", postParameters);
    
    AFHTTPRequestOperation *operation = [super POST:url parameters:postParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = responseObject;
        
        BDLogInfo(@"%@", response);
        
        int status = [response[@"status"] intValue];
        
        finish(operation, status == 1, response[@"data"], response[@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BDLogError(@"%@", error.localizedDescription);
        finish(operation, NO, nil, @"Network connection failure");
    }];
    return operation;
}


- (AFHTTPRequestOperation *)requestGetWithAction:(NSString *)action
                                      parameters:(NSDictionary *)parameters
                                          finish:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, id data, NSString *msg))finish {
    NSString *url = FORMAT(@"%@%@", SERVICE_URL, action);
    
    BDLogInfo(@"%@", url);
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [postParameters setObject:[self getSNWithDic:parameters] forKey:@"sn"];
    
    BDLogInfo(@"%@", postParameters);
    
    AFHTTPRequestOperation *operation = [super GET:url parameters:postParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = responseObject;
        
        BDLogInfo(@"%@", response);
        
        int status = [response[@"status"] intValue];
        
        finish(operation, status == 1, response[@"data"], response[@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BDLogError(@"%@", error.localizedDescription);
        finish(operation, NO, nil, @"Network connection failure");
    }];
    
    return operation;
}

- (NSArray *)sortKeys:(NSDictionary *)dic {
    NSArray *keys = [dic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return sortedArray;
}

- (NSString *)getSNWithDic:(NSDictionary *)dic {
    NSArray *sortedArray = [self sortKeys:dic];
    
    NSMutableString *sn = [NSMutableString string];
    
    for (NSString *key in sortedArray) {
        [sn appendString:[dic[key] asNSString]];
    }
    
    return sn.MD5;
}

@end
