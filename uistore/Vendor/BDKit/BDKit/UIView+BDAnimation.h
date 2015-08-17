//
//  UIView+BDAnimation.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AnimationFadeIn,
    AnimationFadeInFromTop,
    AnimationFadeInFromBottom,
    AnimationFadeInFromRight,
    AnimationFadeInFromLeft,
    
    AnimationFadeOut,
    AnimationPrinter,
    AnimationElasticIn
}AnimationType;

@interface UIView (BDAnimation)

- (void)playAnimation:(AnimationType)type;
- (void)playAnimation:(AnimationType)type delay:(float)delay;
- (void)playAnimation:(AnimationType)type
             duration:(float)duration
                delay:(float)delay
             strength:(float)strength;

@end
