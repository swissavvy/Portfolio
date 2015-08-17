//
//  NJKWebViewProgress.h
//
//  Created by Satoshi Aasano on 4/20/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BDWebViewProgressBlock)(float progress);

@protocol BDWebViewProgressDelegate;

@interface BDWebViewProgress : NSObject<UIWebViewDelegate>

@property (nonatomic, assign) id<BDWebViewProgressDelegate>progressDelegate;
@property (nonatomic, assign) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) BDWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;

@end


@protocol BDWebViewProgressDelegate <NSObject>

- (void)webViewProgress:(BDWebViewProgress *)webViewProgress updateProgress:(float)progress;

@end

