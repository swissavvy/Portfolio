//
//  UserManager.m
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import "UserManager.h"

#import "VLUser.h"

@implementation UserManager

+ (UserManager*)sharedInstance {
    static UserManager* instance = nil;
    if (instance == nil) {
        instance = [[UserManager alloc] init];
    }
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
        registeredUsers = [[NSMutableArray alloc] init];
        
        // Create a test user
        VLUser* defaultTestUser = [[VLUser alloc] initWithID:1];
        defaultTestUser.name = @"Test User";
        defaultTestUser.email = @"test@test.com";
        defaultTestUser.password = @"123";
        
        [registeredUsers addObject:defaultTestUser];
    }
    
    return self;
}

- (VLUser*)currentUser {
    return loggedInUser;
}

- (BOOL)signUserUp:(VLUser*)user {
    BOOL found = NO;
    for (VLUser* aUser in registeredUsers) {
        if ([aUser.email compare:user.email] == NSOrderedSame) {
            found = YES;
            break;
        }
    }
    
    if (! found) {
        user.ID = (registeredUsers.count > 0) ? registeredUsers.count : registeredUsers.count + 1;
        [registeredUsers addObject:user];
    }
    
    return ! found;
}

- (BOOL)logUserInWithEmail:(NSString*)email password:(NSString*)password {
    BOOL found = NO;
    for (VLUser* user in registeredUsers) {
        if (([user.email compare:email] == NSOrderedSame) && ([user.password compare:password] == NSOrderedSame)) {
            found = YES;
            loggedInUser = user;
            break;
        }
    }
    
    return found;
}

- (BOOL)updateUserInformation:(VLUser*)newInformation {
    // First of all check if the email is unique
    for (VLUser* user in registeredUsers) {
        if ((user.ID != newInformation.ID) && ([user.email compare:newInformation.email] == NSOrderedSame)) {
            return NO;
        }
    }
    
    // Now modify the information
    for (int i = 0; i < registeredUsers.count; i++) {
        VLUser* user = registeredUsers[i];
        if (user.ID == newInformation.ID) {
            user.email = newInformation.email;
            user.name = newInformation.name;
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)changeCurrentUserPasswordFrom:(NSString*)currentPassword to:(NSString*)newPassword {
    if ([loggedInUser.password compare:currentPassword] != NSOrderedSame) {
        return NO;
    }
    
    for (int i = 0; i < registeredUsers.count; i++) {
        VLUser* user = registeredUsers[i];
        if (user.ID == loggedInUser.ID) {
            user.password = newPassword;
            return YES;
        }
    }
    
    return NO;
}

- (void)logOut {
    loggedInUser = nil;
}

@end
