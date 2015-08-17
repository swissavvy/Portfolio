//
//  ConnectItem.h
//  BDKit
//
//  Created by Liu Jinyong on 13-9-11.
//  Copyright (c) 2013年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef enum {
    ConnectTypeGET = 0,
    ConnectTypePOST
}ConnectType;

@interface ConnectItem : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, assign) ConnectType type;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, assign) id delegate;
@property (nonatomic, copy) NSString *URL;
@property (nonatomic, retain) ASIFormDataRequest *httpRequest;
@property (nonatomic, assign) id manager;

+ (ConnectItem *)connectWithType:(ConnectType)type
                             url:(NSString *)url
                             tag:(NSString *)tag
                        userInfo:(id)key
                         manager:(id)manager
                        delegate:(id)delegate;


- (ASIFormDataRequest *)configASIRequest;
- (void)start;
- (void)cancel;

@end
