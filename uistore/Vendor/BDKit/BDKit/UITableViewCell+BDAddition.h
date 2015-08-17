//
//  UITableViewCell+BDAddition.h
//  NdGameCenter
//
//  Created by Lin Benjie on 10-12-01.
//  Copyright 2010 NetDragon WebSoft Inc.. All rights reserved.
//

@interface UITableViewCell (BDAddition)

+ (id)dequeOrCreateInTable:(UITableView*)tableView;
+ (id)dequeOrCreateInTable:(UITableView*)tableView ofType: (Class)tp fromNib: (NSString*)nibName withId: (NSString*)reuseId;

+ (id)loadCellOfType: (Class)tp fromNib: (NSString*)nibName withId: (NSString*)reuseId;
+ (id)loadFromNib;
+ (id)loadFromNibWithReuseFlag: (BOOL)toBeReused;

+ (id)dequeOrCreateInTable:(UITableView*)tableView withId: (NSString*)reuseId andStyle:(UITableViewCellStyle)style;

- (void)setSelectedBackgroundColor:(UIColor *)color;

@end