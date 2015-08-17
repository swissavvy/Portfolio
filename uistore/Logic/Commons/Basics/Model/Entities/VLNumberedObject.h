//
//  NumberedObject.h
//  AT Library
//
//  Created  on 9/29/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLObjectParserProtocol.h"

@interface VLNumberedObject : NSObject<VLObjectParserProtocol>

@property (nonatomic) long long ID;

- (id) initWithID:(long)objectID;

@end
