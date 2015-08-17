//
//  BDRouter.h
//  BDKit
//
//  Created by Liu Jinyong on 14-3-26.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(BDRouter)

- (void)setParams:(NSDictionary *)params;

@end



@interface BDRouter : NSObject

+ (instancetype)sharedInstance;

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (UIViewController *)match:(NSString *)route;

@end
