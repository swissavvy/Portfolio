//
//  ThemeManager.m
//  
//
//  Created  on 5/26/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "ThemeManager.h"

#import "Theme.h"

@interface ThemeManager()

- (void)buildColours;

- (void)buildThemes;
- (void)buildRoundedViewTheme;

- (void)applyCornersFromTheme:(Theme*)theme toView:(UIView*)view;
- (void)applyBordersFromTheme:(Theme*)theme toView:(UIView*)view;

@end

@implementation ThemeManager

+ (ThemeManager*)sharedInstance {
    static ThemeManager* instance = nil;
    if (instance == nil) {
        instance = [[ThemeManager alloc] init];
        [instance buildColours];
        [instance buildThemes];
    }
    
    return instance;
}

- (Theme*)roundedViewTheme {
    return roundedViewTheme;
}

- (Theme*)textBoxTheme {
    return textBoxTheme;
}

- (void)applyTheme:(Theme*)theme toLabel:(UILabel*)label {
    label.textColor = theme.textColour;
    label.backgroundColor = theme.backgroundColour;
}

- (void)applyTheme:(Theme*)theme toButton:(UIButton*)button {
    [self applyCornersFromTheme:theme toView:button];
    [self applyBordersFromTheme:theme toView:button];

    button.tintColor = theme.tintColour;
    button.titleLabel.textColor = theme.textColour;
    button.backgroundColor = theme.backgroundColour;
}

- (void)applyTheme:(Theme*)theme toBar:(UINavigationBar*)bar {
    bar.tintColor = theme.textColour;
    bar.barStyle = UIBarStyleBlackOpaque;
    bar.translucent = NO;
    bar.barTintColor = theme.tintColour;
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: theme.textColour};
}

- (void)applyTheme:(Theme*)theme toView:(UIView*)view {
//    view.backgroundColor = theme.backgroundColour;
    [self applyCornersFromTheme:theme toView:view];
    [self applyBordersFromTheme:theme toView:view];
}

- (void)applyTheme:(Theme*)theme toTextField:(UITextField*)field {
//    field.backgroundColor = theme.backgroundColour;
//    field.textColor = theme.textColour;
//    field.tintColor = theme.tintColour;
    field.textAlignment = NSTextAlignmentLeft;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, field.frame.size.height)];
    field.leftView = paddingView;
    field.leftViewMode = UITextFieldViewModeAlways;
    
    [field setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];

    [self applyBordersFromTheme:theme toView:field];
    [self applyCornersFromTheme:theme toView:field];
}

- (void)applyTheme:(Theme *)theme toSegment:(UISegmentedControl*)segment {
    segment.tintColor = theme.tintColour;
}

#pragma mark -
#pragma mark Fonts

- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toLabel:(UILabel*)label {
    NSString* fontName = [NSString stringWithFormat:@"%@-%@", baseFontName, accessory];
    label.font = [UIFont fontWithName:fontName size:label.font.pointSize];
}

- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toButton:(UIButton*)button {
    NSString* fontName = [NSString stringWithFormat:@"%@-%@", baseFontName, accessory];
    button.titleLabel.font = [UIFont fontWithName:fontName size:button.titleLabel.font.pointSize];
}

- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toTextField:(UITextField*)field {
    NSString* fontName = [NSString stringWithFormat:@"%@-%@", baseFontName, accessory];
    field.font = [UIFont fontWithName:fontName size:field.font.pointSize];
}

- (void)applyCustomFont:(NSString*)baseFontName accessory:(NSString*)accessory toView:(UIView*)parentView {
    for (UIView* subView in parentView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [self applyCustomFont:baseFontName accessory:accessory toLabel:(UILabel*)subView];
        }
        else if ([subView isKindOfClass:[UITextField class]]) {
            [self applyCustomFont:baseFontName accessory:accessory toTextField:(UITextField*)subView];
        }
        else if ([subView isKindOfClass:[UIButton class]]) {
            [self applyCustomFont:baseFontName accessory:accessory toButton:(UIButton*)subView];
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)buildColours {
    mainColour = [UIColor blackColor];
    fontColour = [UIColor whiteColor];
    grayColour = [UIColor colorWithRed:239 / 255.0f
                                 green:234 / 255.0f
                                  blue:230 / 255.0f
                                 alpha:1.0f];
}

- (void)buildThemes {
    [self buildRoundedViewTheme];
}

- (void)buildRoundedViewTheme {
    roundedViewTheme = [[Theme alloc] initWithName:@"Rounded View Theme"];
    roundedViewTheme.cornersRadius = ROUNDED_RECT_RADIUS;
}

- (void)applyCornersFromTheme:(Theme*)theme toView:(UIView*)view {
    view.layer.cornerRadius = theme.cornersRadius;
    view.clipsToBounds = YES;
}

- (void)applyBordersFromTheme:(Theme*)theme toView:(UIView*)view {
    view.layer.borderColor = theme.borderColour.CGColor;
    view.layer.borderWidth = theme.borderThickness;
}

@end
