//
//  SideMenuManager.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SideMenuManager : NSObject

+ (SideMenuManager*)sharedInstance;

- (NSArray*)sideMenuItems;

@end
