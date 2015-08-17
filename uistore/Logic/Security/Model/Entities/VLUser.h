//
//  User.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "VLNamedObject.h"

@interface VLUser : VLNamedObject

// The email is the unique username of the user
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* password;

@end
