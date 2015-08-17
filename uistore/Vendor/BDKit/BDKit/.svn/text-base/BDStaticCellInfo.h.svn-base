//
//  PListCellInfo.h
//  BDKit
//
//  Created by Liu Jinyong on 13-10-1.
//  Copyright (c) 2013年 BoDong BaiDu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BD_STATIC_CELL_TITLE                        @"Title"
#define BD_STATIC_CELL_SUBTITLE                     @"Subtitle"
#define BD_STATIC_CELL_TARGET_FUNC                  @"TargetFunction"
#define BD_STATIC_CELL_PUSH_VIEW_CONTROLLER_CLASS   @"PushViewController"
#define BD_STATIC_CELL_UPDATE_FUNC                  @"UpdateFunction"
#define BD_STATIC_CELL_CLASS                        @"CellClass"

@interface BDStaticCellInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) SEL targetFunc;
@property (nonatomic, assign) SEL updateFunc;
@property (nonatomic, assign) Class pushViewControllerClass;
@property (nonatomic, assign) Class cellClass;

+ (NSArray *)loadListFromPList:(NSString *)plistName;

- (id)initWithDictionary:(NSDictionary *)dic;

@end



@protocol BDStaticCellProtocol <NSObject>
@optional
- (void)reloadData:(BDStaticCellInfo *)info;

@end

