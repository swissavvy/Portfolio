//
//  BaseManager.h
//  YAAB Library
//
//  Created  on 11/6/11.
//  Copyright 2011 YAAB. All rights reserved.
//

#import "VLDataDelegate.h"

@interface VLBaseDataManager : NSObject 

// This is the delegate that will get the data
@property (strong, nonatomic) id <VLDataDelegate> delegate;

// This is the request tag
@property (nonatomic) int tag;

- (NSArray*)loadDataFromFile:(NSString*)filePath
                 contentType:(NSString*)contentType
                 resultClass:(Class)resultType;

@end
