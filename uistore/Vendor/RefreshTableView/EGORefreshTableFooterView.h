//
//  EGORefreshTableHeaderView.h
//  Tmart
//
//  Created by zongteng on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

typedef enum{
    EGOOFooterPullRefreshPulling = 0,
    EGOOFooterPullRefreshNormal,
    EGOOFooterPullRefreshLoading,
    EGOOFooterPullRefreshLoaded,
    EGOOFooterPullRefreshLoadFailed
} EGOFooterPullRefreshState;

@protocol EGORefreshTableFooterDelegate;

@interface EGORefreshTableFooterView : UIView {
    EGOFooterPullRefreshState _state;
    UIButton *_statusButton;
    UIActivityIndicatorView *_activityView;
    UIView *_separatorLine;
}

@property (nonatomic, assign) id <EGORefreshTableFooterDelegate> delegate;

- (void)setState:(EGOFooterPullRefreshState)aState;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol EGORefreshTableFooterDelegate<NSObject>

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;

@end
