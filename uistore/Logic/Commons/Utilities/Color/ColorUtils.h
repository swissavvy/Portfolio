//
//  ColorUtils.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (ColorUtils*)sharedInstance;

- (UIColor*)colorWithHexString:(NSString*)hex;

@end
