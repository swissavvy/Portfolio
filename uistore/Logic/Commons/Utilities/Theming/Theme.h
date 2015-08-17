//
//  Theme.h
//  
//
//  Created  on 6/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "VLNamedObject.h"

@interface Theme : VLNamedObject

// Font and backgrounds
@property (strong, nonatomic) UIColor* tintColour;
@property (strong, nonatomic) UIColor* textColour;
@property (strong, nonatomic) UIColor* backgroundColour;

// Border themeing
@property (strong, nonatomic) UIColor* borderColour;
@property (nonatomic) float borderThickness;

// Rounding
@property (nonatomic) float cornersRadius;

@end
