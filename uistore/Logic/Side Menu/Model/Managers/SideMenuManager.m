//
//  SideMenuManager.m
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "SideMenuManager.h"

#import "VLFileManager.h"
#import "VLPListParser.h"
#import "SideMenuItem.h"

@implementation SideMenuManager

+ (SideMenuManager*)sharedInstance {
    static SideMenuManager* instance = nil;
    if (instance == nil) {
        instance = [[SideMenuManager alloc] init];
    }
    
    return instance;
}

- (NSArray*)sideMenuItems {
    NSString* filePath = [[VLFileManager sharedInstance] filePathInBundle:@"SideMenu" withExtention:@"plist"];
    NSArray* items = [[VLPListParser sharedInstance] parsePListData:[NSData dataWithContentsOfFile:filePath]
                                                           toObject:[SideMenuItem class]];
    return items;
}

@end
