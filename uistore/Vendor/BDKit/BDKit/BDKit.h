//
//  BDKit.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-19.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#ifndef BDKit_h
#define BDKit_h

#pragma mark - 宏

#import "BDMacro.h"


#pragma mark - System

#import "BDApp.h"
#import "BDDisk.h"
#import "BDHardware.h"


#pragma mark - Foundation

#import "BDBaseFunc.h"
#import "BDInterApp.h"
#import "BDRouter.h"
#import "BDLog.h"

#import "BDSynthesizeSingleton.h"
#import "BDARCSynthesizeSingleton.h"
#import "BDTaskQueue.h"
#import "BDSandbox.h"
#import "BDKVOController.h"

// Cache
#import "BDCacheProtocol.h"
#import "BDFileCache.h"
#import "BDMemoryCache.h"
#import "BDKeychain.h"


#pragma mark - Foundation Extension

#import "NSInvocation+BDConvenent.h"

#import "NSString+BDAddition.h"

#import "NSMutableDictionary+BDAddition.h"

#import "NSNotification+BDKeyboard.h"

#import "NSDate+BDAddition.h"

#import "NSData+BDAddition.h"

#import "NSArray+BDAddition.h"

#import "NSMutableSet+BDExtension.h"

#import "NSDictionary+BDAddition.h"

#import "NSObject+BDTypeConversion.h"
#import "NSObject+BDAssociation.h"
#import "NSObject+BDAutoDescription.h"
#import "NSObject+BDLogDealloc.h"
#import "NSObject+BDLifeCycle.h"

#import "NSTimer+BDExtension.h"


#pragma mark - View
// Block
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "BlockItem.h"
#import "UIControl+BDBlock.h"

#import "BDLineLabel.h"
#import "BDLabel.h"
#import "BDStretchableButton.h"
#import "BDStretchableImageView.h"
#import "Toast.h"
#import "BDPageControl.h"
#import "BDTipWindow.h"
#import "BDCellAccessory.h"
#import "BDTextView.h"

#import "BDViewRecycler.h"
#import "BDRecyclableView.h"

//Theme
#import "BDThemeManager.h"
#import "BDThemeUpdateProtocol.h"
#import "BDThemeView.h"
#import "BDThemeTextView.h"
#import "BDThemeTextField.h"
#import "BDThemeLabel.h"
#import "BDThemeImageView.h"
#import "BDThemeTableViewCell.h"


#pragma mark - View Extension

#import "CGRect+BDAdditions.h"

#import "UIView+BDConvenience.h"
#import "UIView+BDAnimation.h"
#import "UIView+BDNib.h"
#import "UIView+BDToast.h"
#import "UIView+BDUtility.h"
#import "UIView+BDBackground.h"
#import "UIView+BDTag.h"
#import "UIView+BDLayer.h"

#import "UIColor+BDAddition.h"

#import "UIAlertView+BDAddition.h"

#import "UIImage+BDAddition.h"

#import "UIActivityIndicatorView+BDConvenient.h"

#import "UITableView+BDAddition.h"

#import "UILabel+BDAddition.h"

#import "UITableViewCell+BDAddition.h"

#import "UIButton+BDAddition.h"


#pragma mark - Model

#import "BDModel.h"


#pragma mark - Controller

#import "BDTabBarController.h"
#import "BDTabBarButton.h"

#import "BDStaticCellInfo.h"
#import "BDStaticTableViewController.h"
#import "UIViewController+BDPopupViewController.h"
#import "UIViewController+BDAddition.h"
#import "UIViewController+BDKeyboard.h"
#import "UIViewController+BDPopin.h"

#pragma mark - Controller Extension

#import "UIViewController+BDNavigationBar.h"
#import "UIViewController+BDExpandTableView.h"


#endif

