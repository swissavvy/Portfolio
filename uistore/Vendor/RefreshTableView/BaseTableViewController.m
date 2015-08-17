//
//  BaseTableViewController.m
//  Pocket91
//
//  Created by yi_dq on 2/9/13.
//  Copyright (c) 2013 Bodong Baidu. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

- (void)setupContentTableView;

@end

@implementation BaseTableViewController

#pragma mark - view life

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupContentTableView];
}

- (void)setupContentTableView {
    self.tableView = [[RefreshTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.refreshDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView refreshTableViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView refreshTableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView refreshTableViewDidEndDragging:scrollView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
