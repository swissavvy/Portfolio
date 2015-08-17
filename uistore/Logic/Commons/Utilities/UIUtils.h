//
//  UIUtils.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

+ (UIUtils*)sharedInstance;

- (UIImage*)imageFromView:(UIView*)view;
- (void)setPagesImagesInControl:(UIPageControl*)control selectedImage:(UIImage*)selectedImage normalImage:(UIImage*)normalImage;
- (void)setImage:(UIImage*)imageObject forBarInController:(UIViewController*)controller withTitle:(NSString*)title withTag:(int)tag;

@end
