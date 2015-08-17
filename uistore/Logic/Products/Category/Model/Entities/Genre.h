//
//  Genre.h
//  uistore
//
//  Created  on 8/26/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "VLNamedObject.h"

@interface Genre : VLNamedObject<VLObjectParserProtocol>

@property (strong, nonatomic) NSArray* categories;

+ (Genre*)menGenre;
+ (Genre*)womenGenre;

@end
