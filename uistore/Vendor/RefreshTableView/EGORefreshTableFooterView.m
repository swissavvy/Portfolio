//
//  EGORefreshTableHeaderView.m
//  Tmart
//
//  Created by zongteng on 12-1-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EGORefreshTableFooterView.h"
#import <QuartzCore/QuartzCore.h>

#define  RefreshViewHight 65.0f
#define TEXT_COLOR     [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@implementation EGORefreshTableFooterView

@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self){
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _statusButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_statusButton addTarget:self action:@selector(getMoreData) forControlEvents:UIControlEventTouchUpInside];
        _statusButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [_statusButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
        _statusButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_statusButton];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(100.0f, (self.frame.size.height - 20.0f) / 2, 20.0f, 20.0f);
        [self addSubview:_activityView];
        
        _separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 2)];
        [self addSubview:_separatorLine];
        
        [self setState:EGOOFooterPullRefreshNormal];
    }
    
    return self;
    
}

#pragma mark - Setters

- (void)setState:(EGOFooterPullRefreshState)aState {
    switch (aState) {
        case EGOOFooterPullRefreshNormal:
            [_statusButton setTitle:@"Pull up to refresh status" forState:UIControlStateNormal];
            [_activityView stopAnimating];
            break;
        case EGOOFooterPullRefreshLoading:
            [_statusButton setTitle:@"Loading..." forState:UIControlStateNormal];
            [_activityView startAnimating];
            break;
        case EGOOFooterPullRefreshLoaded:
            [_statusButton setTitle:@"All data has been loaded" forState:UIControlStateNormal];
            [_activityView stopAnimating];
            break;
        case EGOOFooterPullRefreshLoadFailed:
            [_statusButton setTitle:@"Failed to load!" forState:UIControlStateNormal];
            [_activityView stopAnimating];
            break;
        default:
            break;
    }
    
    _state = aState;
}


#pragma mark - ScrollView Methods

//手指屏幕上不断拖动调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        if (_state == EGOOFooterPullRefreshNormal && scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - 20.f) {
            [self setState:EGOOFooterPullRefreshLoading];
            DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, egoRefreshTableFooterDidTriggerRefresh:, self);
        }
    }
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
}

//当开发者页面页面刷新完毕调用此方法，[delegate egoRefreshScrollViewDataSourceDidFinishedLoading: scrollView];
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    if(_state != EGOOFooterPullRefreshLoaded && _state != EGOOFooterPullRefreshLoadFailed){
        [self setState:EGOOFooterPullRefreshNormal];
    }
}

#pragma mark - button action

- (void)getMoreData {
    if (_state == EGOOFooterPullRefreshLoaded) {
        return;
    }
    
    [self setState:EGOOFooterPullRefreshLoading];
    DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, egoRefreshTableFooterDidTriggerRefresh:, self);
}

@end
