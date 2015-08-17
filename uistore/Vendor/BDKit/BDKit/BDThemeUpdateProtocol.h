//
//  BDThemeUpdateProtocol.h
//  BDKit
//
//  Created by Liu Jinyong on 14-4-18.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BDThemeUpdateProtocol <NSObject>

@required

// 使用主题时调用一次。每次接收到通知后，调用一次。
- (void)applyTheme;

@end
