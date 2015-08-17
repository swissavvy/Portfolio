//
//  BDViewRecycler.h
//  BDKit
//
//  Created by Liu Jinyong on 14-3-14.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 @code
 for (UIView<NIRecyclableView>* view in visibleViews) {
 if (![self isVisible:view]) {
 [viewRecycler recycleView:view];
 [view removeFromSuperview];
 }
 }
 @endcode
 
 @code
 UIView<NIRecyclableView>* view = [viewRecycler dequeueReusableViewWithIdentifier:reuseIdentifier];
 if (nil == view) {
 // Allocate a new view that conforms to the NIRecyclableView protocol.
 view = [[[...]] autorelease];
 }
 [self addSubview:view];
 @endcode
 */

@protocol BDRecyclableViewProtocol;

@interface BDViewRecycler : NSObject

- (UIView<BDRecyclableViewProtocol> *)dequeueReusableViewWithIdentifier:(NSString *)reuseIdentifier;
- (void)recycleView:(UIView<BDRecyclableViewProtocol> *)view;
- (void)removeAllViews;

@end


@protocol BDRecyclableViewProtocol <NSObject>

@optional

// 如果reuseIdentifier 为空，则使用类名作为reuseIdentifier
@property (nonatomic, copy) NSString *reuseIdentifier;

// 当view从回收池中出列时，该方法立即被调用
- (void)prepareForReuse;

@end

