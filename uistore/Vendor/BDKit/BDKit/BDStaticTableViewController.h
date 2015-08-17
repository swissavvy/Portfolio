//
//  StaticTableViewController.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-12.
//  Copyright (c) 2014年 BoDong BaiDu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDStaticCellInfo.h"

@interface BDStaticTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *cells;

- (void)reloadWithDefaultCellClass:(Class)defaultCellClass;

- (void)reloadWithPlist:(NSString *)plistName
       defaultCellClass:(Class)defaultCellClass;

//子类重写该方法，绘制cell。
- (void)cell:(id)cell willUpdateAtIndexPath:(NSIndexPath *)indexPath info:(BDStaticCellInfo *)info;

@end
