//
//  BDThemeTableViewCell.h
//  BDKit
//
//  Created by Liu Jinyong on 14-4-30.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDThemeTableViewCell : UITableViewCell<BDThemeUpdateProtocol>

@property (nonatomic, strong) NSString *selectedBackgroundColorKey;
@property (nonatomic, strong) NSString *backgroundColorKey;

@end
