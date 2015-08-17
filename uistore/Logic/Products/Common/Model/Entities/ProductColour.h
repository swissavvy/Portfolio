//
//  ProductColour.h
//  uistore
//
//  Created  on 9/2/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "VLNamedObject.h"

@interface ProductColour : VLNamedObject<VLObjectParserProtocol>

@property (strong, nonatomic) NSString* colourCode;

@property (strong, nonatomic, readonly) UIColor* uiColor;

@end
