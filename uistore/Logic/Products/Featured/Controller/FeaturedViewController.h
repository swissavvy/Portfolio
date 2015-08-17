//
//  FeaturedViewController.h
//  uistore
//
//  Created  on 8/25/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedViewController : UIViewController<UIScrollViewDelegate> {
    @private
    NSArray* featuredItems;
}

@property (weak, nonatomic) IBOutlet UIScrollView* productsContainer;
@property (weak, nonatomic) IBOutlet UIPageControl* pager;

@property (weak, nonatomic) IBOutlet UIView* menView;
@property (weak, nonatomic) IBOutlet UIView* womenView;

@property (weak, nonatomic) IBOutlet UILabel* lblMen;
@property (weak, nonatomic) IBOutlet UILabel* lblWomen;

@end
