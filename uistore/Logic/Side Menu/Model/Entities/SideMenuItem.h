//
//  SideMenuItem.h
//  uistore
//
//  Created  on 8/24/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VLNamedObject.h"

@interface SideMenuItem : VLNamedObject<VLObjectParserProtocol>

@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSString* segue;

@end
