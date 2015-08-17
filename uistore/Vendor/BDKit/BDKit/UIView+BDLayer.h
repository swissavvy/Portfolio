//
//  UIView+Layer.h
//  BDKit
//
//  Created by Liu Jinyong on 14-6-29.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDLayer)

@property (nonatomic, BD_STRONG) UIColor *borderColor;
@property (nonatomic, assign) float borderWidth;
@property (nonatomic, assign) float cornerRadius;

@end
