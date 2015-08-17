//
//  BaseTableViewController.h
//  Pocket91
//
//  Created by yi_dq on 2/9/13.
//  Copyright (c) 2013 Bodong Baidu. All rights reserved.
//  Review Date 2013-09-18

#import "RefreshTableView.h"

@interface BaseTableViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    RefreshTableViewDelegate>

@property (nonatomic, strong) RefreshTableView *tableView;

@end
