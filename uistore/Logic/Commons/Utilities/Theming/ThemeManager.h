//
//  ThemeManager.h
//  
//
//  Created  on 5/26/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class Theme;

@interface ThemeManager : NSObject {
    @private
    UIColor* mainColour;
    UIColor* fontColour;
    UIColor* grayColour;

    Theme* roundedViewTheme;
    Theme* textBoxTheme;
}

+ (ThemeManager*)sharedInstance;

- (Theme*)roundedViewTheme;
- (Theme*)textBoxTheme;

- (void)applyTheme:(Theme*)theme toLabel:(UILabel*)label;
- (void)applyTheme:(Theme*)theme toButton:(UIButton*)button;
- (void)applyTheme:(Theme*)theme toBar:(UINavigationBar*)bar;
- (void)applyTheme:(Theme*)theme toView:(UIView*)view;
- (void)applyTheme:(Theme*)theme toTextField:(UITextField*)field;
- (void)applyTheme:(Theme*)theme toSegment:(UISegmentedControl*)segment;

#pragma mark -
#pragma mark Fonts

- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toLabel:(UILabel*)label;
- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toButton:(UIButton*)button;
- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toTextField:(UITextField*)field;
- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toView:(UIView*)parentView;

@end
