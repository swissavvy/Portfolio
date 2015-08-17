//
//  UserManager.h
//  uistore
//
//  Created  on 9/9/14.
//  Copyright (c) 2014 Moka+. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VLUser;

@interface UserManager : NSObject {
    @private
    // This is the current logged in user; nil if no one logged in
    VLUser* loggedInUser;
    
    // This array contains all the registered users, it should be in the server's database
    NSMutableArray* registeredUsers;
}

+ (UserManager*)sharedInstance;

// This method returns the information of the currently logged in user
- (VLUser*)currentUser;

// This method signs the user up if his email doesn't exist in the registered users list
- (BOOL)signUserUp:(VLUser*)user;

// This method logs the user in if he exists in the registered users list
- (BOOL)logUserInWithEmail:(NSString*)email password:(NSString*)password;

// This method modifies the current logged in user's information based on the passed data
- (BOOL)updateUserInformation:(VLUser*)newInformation;

// This method tries to change the password of the current user, returns NO if the original password is not correct
- (BOOL)changeCurrentUserPasswordFrom:(NSString*)currentPassword to:(NSString*)newPassword;

// This method logs the user out
- (void)logOut;

@end
