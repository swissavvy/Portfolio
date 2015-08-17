//
//  BDHardware.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>

/*!
 * This class check some hardware (and software) informations
 */
@interface BDHardware : NSObject

/*!
 Check the device model
 @return NSString with the device model
 */
+ (NSString *)deviceModel;

/*!
 Check the device name
 @return NSString with the device name
 */
+ (NSString *)deviceName;

/*!
 Check the system name
 @return NSString with the system name
 */
+ (NSString *)systemName;

/*!
 Check the system version
 @return NSString with the system version
 */
+ (NSString *)systemVersion;

/*!
 Check the screen width in pixel
 @return NSInteger value of the width of the screen
 */
+ (NSInteger)screenWidth;

/*!
 Check the screen height in pixel
 @return NSInteger value of the height of the screen
 */
+ (NSInteger)screenHeight;

/*!
 Check the screen brightness
 @return CGFloat value of the brightness of the screen
 */
+ (CGFloat)brightness;

/*!
 Get the device type
 @return NSString represents the platform type (ex. : iPhone 5)
 */
+ (NSString *)platformType;

/*!
 Get the boot time in hours, minutes and seconds
 @return NSString represents the boot time in hours, minutes and seconds
 */
+ (NSDate *)bootTime;

/*!
 Check if the multitasking is enabled
 @return YES if the multitasking is enabled, NO if it isn't
 */
+ (BOOL)multitaskingEnabled;



@end
