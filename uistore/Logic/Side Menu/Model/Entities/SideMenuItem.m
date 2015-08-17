//
//  SideMenuItem.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "SideMenuItem.h"

#define SIDE_MENU_ITEM_ID         @"ID"
#define SIDE_MENU_ITEM_NAME       @"Name"
#define SIDE_MENU_ITEM_IMAGE_NAME @"Image"
#define SIDE_MENU_ITEM_SEGUE      @"Segue"

@implementation SideMenuItem

- (id)initWithDictionary:(NSDictionary *)dataDictionary {
    if (self = [super init]) {
        [self parse:dataDictionary];
    }
    
    return self;
}

- (BOOL)parse:(NSDictionary *)dataDictionary {
    if (dataDictionary == nil) {
        return NO;
    }
    
    self.ID = [dataDictionary[SIDE_MENU_ITEM_ID] longLongValue];
    self.name = dataDictionary[SIDE_MENU_ITEM_NAME];
    self.image = [UIImage imageNamed:dataDictionary[SIDE_MENU_ITEM_IMAGE_NAME]];
    self.segue = dataDictionary[SIDE_MENU_ITEM_SEGUE];
    
    return YES;
}

@end
