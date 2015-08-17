//
//  BDThemedImageView.h
//  BDKit
//
//  Created by Liu Jinyong on 14-4-18.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDThemeUpdateProtocol.h"

@interface BDThemeImageView : UIImageView<BDThemeUpdateProtocol>

@property (strong, nonatomic) NSString *imageKey;
@property (nonatomic, strong) NSString *backgroundColorKey;

@end
