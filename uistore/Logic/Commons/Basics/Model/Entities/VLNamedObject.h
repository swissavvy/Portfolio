//
//  NamedObject.h
//  AT Library
//
//  Created  on 7/27/12.
//  Copyright (c) 2012  Inc. All rights reserved.
//

#import "VLNumberedObject.h"

#import "VLObjectParserProtocol.h"

@interface VLNamedObject : VLNumberedObject<VLObjectParserProtocol>

@property (strong, nonatomic) NSString* name;

- (id) initWithName:(NSString*)objectName;

@end
