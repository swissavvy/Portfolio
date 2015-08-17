//
//  DescribedObject.m
//  AT Library
//
//  Created  on 7/29/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLDescribedObject.h"

@implementation VLDescribedObject

- (id) initWithDescription:(NSString*)descriptionToSet {
    if (self = [super init]) {
        self.description = descriptionToSet;
    }

    return self;
}

@end
