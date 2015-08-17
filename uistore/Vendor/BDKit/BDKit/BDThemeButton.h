//
//  BDThemeButton.h
//  BDKit
//
//  Created by Liu Jinyong on 14-4-18.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDThemeUpdateProtocol.h"

@interface BDThemeButton : UIButton<BDThemeUpdateProtocol>

@property (nonatomic, strong) NSString *normalImageKey;
@property (nonatomic, strong) NSString *highlightedImageKey;
@property (nonatomic, strong) NSString *selectedImageKey;

@property (nonatomic, strong) NSString *fontKey;
@property (nonatomic, strong) NSString *textColorKey;
@property (nonatomic, strong) NSString *highlightedTextColorKey;
@property (nonatomic, strong) NSString *selectedTextColorKey;

@property (nonatomic, strong) NSString *backgroundImageKey;
@property (nonatomic, strong) NSString *backgroundColorKey;

@end
