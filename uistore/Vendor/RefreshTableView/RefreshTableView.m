//
//  CustomTableView.m
//  TableViewPull
//
//  Created by lory qing on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RefreshTableView.h"

@interface RefreshTableView() {
    CGPoint _point;//判断是上拉还是下拉
    
    BOOL _reloading;
}

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;

@end

@implementation RefreshTableView

#pragma mark - public methods

- (void)setRefreshType:(RefreshType)refreshType {
    _refreshType = refreshType;
    
    [self removeHeaderAndFooterView];
    if (refreshType == RefreshTypeHeader) {
        [self addHeaderRefreshView];
    }else if(refreshType == RefreshTypeFooter){
        [self addFooterRefreshView];
    }else if(refreshType == RefreshTypeBoth){
        [self addHeaderRefreshView];
        [self addFooterRefreshView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)setRefreshBackgroundColor:(UIColor *)backgroundColor
{
    if(_refreshHeaderView != nil) {
        _refreshHeaderView.backgroundColor = backgroundColor;
    }
    if(_refreshFooterView != nil) {
        _refreshFooterView.backgroundColor = backgroundColor;
    }
}

// 此下两个函数是触发动作的开始  即拖拽动作
- (void)refreshTableViewWillBeginDragging:(UIScrollView *)scrollView{
	_point =scrollView.contentOffset;
}

- (void)refreshTableViewDidScroll:(UIScrollView *)scrollView{
    if (_reloading) {
        return;
    }
    
	CGPoint pt =scrollView.contentOffset;
    if (_point.y > pt.y) {//向下拉加载更多
        [_refreshHeaderView egoRefreshScrollViewDidScroll:self];
    }else if(!_isLoadedAllTheData){//向上提加载更多 且 没有加载完服务器端数据
        [_refreshFooterView egoRefreshScrollViewDidScroll:self];
    }
	
}

- (void)refreshTableViewDidEndDragging:(UIScrollView *)scrollView{
    if (_reloading) {
        return;
    }
    
    CGPoint pt =scrollView.contentOffset;
    if (_point.y > pt.y) {//向下拉加载更多
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self];
    }else if(!_isLoadedAllTheData){ //向上提加载更多 且 没有加载完服务器端数据
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:self];
    }
}

- (void)requestReloadData {
    if (_reloading) {
        return;
    }
    
    [self setContentOffset:CGPointMake(0, -67) animated:YES];
    [self performSelector:@selector(requestReloadData2) withObject:nil afterDelay:0.3];
}

- (void)requestReloadData2 {
    [self setContentOffset:CGPointMake(0, -67) animated:NO];
    [self refreshTableViewDidEndDragging:self];
}

#pragma mark - Data Source Loading / Reloading Methods

- (void)reloadTableViewHeaderDataSource {
    _reloading = YES;
    if (_isLoadedAllTheData) {
        _isLoadedAllTheData = NO;
        [self addSubview:_refreshFooterView];
    }
    DELEGATE_CALLBACK_ONE_PARAMETER(_refreshDelegate, refreshTableViewRequestHeaderDataSoure:, self);
}

- (void)reloadTableViewFooterDataSource {
    _reloading = YES;
    DELEGATE_CALLBACK_ONE_PARAMETER(_refreshDelegate, refreshTableViewRequestFooterDataSoure:, self);
}

- (void)finishLoading {
    [self reloadFooterRefreshView];
    
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
	[_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)reloadFooterRefreshView {
    if(_refreshFooterView != nil){
        if(self.contentSize.height <= _refreshFooterView.height){
            _refreshFooterView.hidden = YES;
        }else {
            if(self.contentSize.height <= self.height){
                [self hideFooterViewWhenLoaded:YES];
            }else {
                [self hideFooterViewWhenLoaded:NO];
            }
        }
    }
}

- (void)hideFooterViewWhenLoaded:(BOOL)isHide
{
    if (_isLoadedAllTheData) {
        _refreshFooterView.hidden = isHide;
    }else {
        _refreshFooterView.hidden = NO;
    }
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	
	[self reloadTableViewHeaderDataSource];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    NSDate *lastUpdate = nil;
    if ([_refreshDelegate respondsToSelector:@selector(refreshTableViewLastUpdate:)]) {
        lastUpdate = [_refreshDelegate refreshTableViewLastUpdate:self];
    }
	return lastUpdate ? lastUpdate : [NSDate date];
}

#pragma mark EGORefreshTableFooterDelegate Methods

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view {
	[self reloadTableViewFooterDataSource];
}


#pragma mark - private methods

- (void)addHeaderRefreshView {
	if (_refreshHeaderView == nil) {
		_refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.frame.size.height, self.frame.size.width, self.frame.size.height)];
		_refreshHeaderView.delegate = self;
	}
    [self addSubview:_refreshHeaderView];
}

- (void)addFooterRefreshView {
	if (_refreshFooterView == nil) {
		_refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame: CGRectMake(0.0f, 0.0, self.frame.size.width, 40.0f)];
		_refreshFooterView.delegate = self;
        _refreshFooterView.hidden = YES;
	}
    self.tableFooterView = _refreshFooterView;
}

- (void)removeHeaderAndFooterView {
    if(_refreshHeaderView != nil) {
        [_refreshHeaderView removeFromSuperview];
        _refreshHeaderView = nil;
    }
    if(_refreshFooterView != nil) {
        [_refreshFooterView removeFromSuperview];
        _refreshFooterView = nil;
    }
}

- (void)setIsLoadedAllTheData:(BOOL)isLoadedAllTheData {
    if(isLoadedAllTheData){
        [_refreshFooterView setState:EGOOFooterPullRefreshLoaded];
    }else {
        [_refreshFooterView setState:EGOOFooterPullRefreshNormal];
    }
    _isLoadedAllTheData = isLoadedAllTheData;
}

- (void)setIsLoadFailed:(BOOL)isLoadFailed {
    if(isLoadFailed){
        [_refreshFooterView setState:EGOOFooterPullRefreshLoadFailed];
    }
}

@end
