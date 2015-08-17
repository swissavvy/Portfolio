//
//  BDPageControl.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

typedef enum {
	PageControlTypeOnFullOffEmpty = 0,
	PageControlTypeOnFullOffFull,
	PageControlTypeOnEmptyOffFull,
	PageControlTypeOnEmptyOffEmpty
}BDPageControlType;

@interface BDPageControl : UIControl

// Replicate UIPageControl function
@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic) BOOL hidesForSinglePage;
@property(nonatomic) BOOL defersCurrentPageDisplay;

// Addition UIPageControl function
@property (nonatomic) BDPageControlType type;
@property (nonatomic, retain) UIColor *onColor;
@property (nonatomic, retain) UIColor *offColor;
@property (nonatomic) CGFloat indicatorDiameter;
@property (nonatomic) CGFloat indicatorSpace;

- (void)updateCurrentPageDisplay;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;
- (id)initWithType:(BDPageControlType)theType;


@end

