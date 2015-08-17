//
//  CategoryViewController.m
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "CategoryViewController.h"

#import "Genre.h"
#import "ProductCategory.h"
#import "CategoryManager.h"

#import "UIUtils.h"

#import "Theme.h"
#import "ThemeManager.h"

#import "ProductListingViewController.h"

#import "CategoryTableViewCell.h"

@interface CategoryViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation CategoryViewController

#pragma mark -
#pragma mark Controller Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier compare:@"categoryProductsSegue"] == NSOrderedSame) {
        ((ProductListingViewController*)segue.destinationViewController).cateogry = self.dataList[self.tableView.indexPathForSelectedRow.row];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIUtils sharedInstance] setImage:[UIImage imageNamed:@"Navigation Bar Background"]
                    forBarInController:self
                             withTitle:@"Category"
                               withTag:TAG_NAV_BAR_BACKGROUND];
    
    // Back button for the next views without a title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    
    SHOW_LOADING;
    [[RequestManager manager] requestGetWithAction:@"api/product/category" parameters:nil finish:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSDictionary *data, NSString *msg) {
        HIDE_HUD;
        if (isSuccess) {
            _dataList = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                [self getCategory:dic];
            }
            [self.tableView reloadData];
        }else {
            [Toast showText:msg];
        }
    }];
}

- (void)getCategory:(NSDictionary *)dic {
    if ([dic[@"items"] count] > 0) {
        for (NSDictionary *subdic in dic[@"items"]) {
            [self getCategory:subdic];
        }
    }else {
        [_dataList addObject:[[ProductCategory alloc] initWithDictionary:dic]];
    }
}

#pragma mark -
#pragma mark Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    
    ProductCategory* category = self.dataList[indexPath.row];
    cell.lblName.text = category.name;
    
    // Apply Custom Font
    [[ThemeManager sharedInstance] applyCustomFont:OPEN_SANS_FONT_BASE_NAME
                                         accessory:OPEN_SANS_FONT_ACCESSORY_REGULAR
                                           toLabel:cell.lblName];
    
    return cell;
}

@end
