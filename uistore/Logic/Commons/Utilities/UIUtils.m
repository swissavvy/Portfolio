//
//  UIUtils.m
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "UIUtils.h"

#import "ThemeManager.h"
#import "Theme.h"

@implementation UIUtils

+ (UIUtils*)sharedInstance {
    static UIUtils* instance = nil;
    if (instance == nil) {
        instance = [[UIUtils alloc] init];
    }
    
    return instance;
}

- (UIImage*)imageFromView:(UIView*)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

- (void)setPagesImagesInControl:(UIPageControl*)control selectedImage:(UIImage*)selectedImage normalImage:(UIImage*)normalImage {
    for (int i = 0; i < control.subviews.count; i++) {
        UIView* dotView = control.subviews[i];
        UIImageView* dot = nil;
        for (UIView* subview in dotView.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView*)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
            [dotView addSubview:dot];
        }
        
        if (i == control.currentPage) {
            dot.image = selectedImage;
        }
        else {
            dot.image = normalImage;
        }
    }
}

- (void)setImage:(UIImage*)imageObject forBarInController:(UIViewController*)controller withTitle:(NSString*)title withTag:(int)tag {
//    UIImageView* olderView = (UIImageView*)[controller.navigationController.navigationBar viewWithTag:tag];
//    if (olderView != nil) {
//        olderView.image = imageObject;
//        [controller.navigationController.navigationBar sendSubviewToBack:olderView];
//    }
//    else {
//        UIImageView* image = [[UIImageView alloc] initWithImage:imageObject];
//        image.frame = CGRectMake(0, -[UIApplication sharedApplication].statusBarFrame.size.height, controller.view.bounds.size.width, imageObject.size.height);
//        image.tag = tag;
//        [controller.navigationController.navigationBar addSubview:image];
//    }

    [controller.navigationController.navigationBar setBackgroundImage:imageObject forBarMetrics:UIBarMetricsDefault];
    
    // Set the title view
    UIView* oldTitleView = [controller.navigationController.navigationBar viewWithTag:TAG_NAV_BAR_TITLE];
    if ((oldTitleView != nil) && ([oldTitleView isKindOfClass:[UILabel class]])) {
        [oldTitleView removeFromSuperview];
    }
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, controller.navigationController.navigationBar.frame.size.height)];
    titleLabel.text = title;
    titleLabel.tag = TAG_NAV_BAR_TITLE;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_SEMI_BOLD
                                           toLabel:titleLabel];    
    [controller.navigationController.navigationBar addSubview:titleLabel];
    
    // Bring the left and right buttons to front
    UIView* subView = [controller.navigationItem.rightBarButtonItem valueForKey:@"view"];
    [controller.navigationController.navigationBar bringSubviewToFront:subView];
    
    subView = [controller.navigationItem.leftBarButtonItem valueForKey:@"view"];
    [controller.navigationController.navigationBar bringSubviewToFront:subView];

}

@end
