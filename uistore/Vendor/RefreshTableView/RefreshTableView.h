//
//  CustomTableView.h
//  TableViewPull
//
//  Created by lory qing on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

#define SYNTHESIZE_TABLE_VIEW_DELEGATE_METHOD(__TABLE_VIEW__)   \
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{  \
if (scrollView == __TABLE_VIEW__) { \
[__TABLE_VIEW__ refreshTableViewWillBeginDragging:scrollView];   \
}   \
}   \
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{  \
if (scrollView == __TABLE_VIEW__) { \
[__TABLE_VIEW__ refreshTableViewDidScroll:scrollView];   \
}   \
}   \
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ \
if (scrollView == __TABLE_VIEW__) { \
[__TABLE_VIEW__ refreshTableViewDidEndDragging:scrollView];  \
}\
}

typedef enum{
    RefreshTypeNone = 0,
    RefreshTypeHeader,
    RefreshTypeFooter,
    RefreshTypeBoth
}RefreshType;

@protocol RefreshTableViewDelegate;




@interface RefreshTableView : UITableView<EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>

@property (nonatomic, assign) BOOL isLoadedAllTheData;
@property (nonatomic, assign) BOOL isLoadFailed;
@property (nonatomic, assign) IBOutlet id<RefreshTableViewDelegate> refreshDelegate;
@property (nonatomic, assign) RefreshType refreshType;

- (void)requestReloadData;
- (void)finishLoading;

- (void)refreshTableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)refreshTableViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshTableViewDidEndDragging:(UIScrollView *)scrollView;

@end



@protocol RefreshTableViewDelegate <NSObject>

@optional
- (void)refreshTableViewRequestHeaderDataSoure:(RefreshTableView *)tableView;
- (void)refreshTableViewRequestFooterDataSoure:(RefreshTableView *)tableView;
- (NSDate *)refreshTableViewLastUpdate:(RefreshTableView *)tableView;

@end