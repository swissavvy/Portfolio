//
//  BDLog.h
//  BDKit
//
//  Created by Liu Jinyong on 12/30/14.
//  Copyright (c) 2014 Bodong Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, BDLogFlag) {
    BDLogFlagError      = (1 << 0),
    BDLogFlagWarning    = (1 << 1),
    BDLogFlagInfo       = (1 << 2),
    BDLogFlagDebug      = (1 << 3),
    BDLogFlagVerbose    = (1 << 4)
};

typedef NS_ENUM(NSUInteger, BDLogLevel) {
    BDLogLevelOff       = 0,
    BDLogLevelError     = (BDLogFlagError),
    BDLogLevelWarning   = (BDLogLevelError   | BDLogFlagWarning),
    BDLogLevelInfo      = (BDLogLevelWarning | BDLogFlagInfo),
    BDLogLevelDebug     = (BDLogLevelInfo    | BDLogFlagDebug),
    BDLogLevelVerbose   = (BDLogLevelDebug   | BDLogFlagVerbose),
    BDLogLevelAll       = NSUIntegerMax
};


#if DEBUG
static const BDLogLevel bdLogLevel = BDLogLevelVerbose;
#else
static const BDLogLevel bdLogLevel = BDLogLevelWarning;
#endif


#ifndef BD_LOG_LEVEL_DEF
#define BD_LOG_LEVEL_DEF bdLogLevel
#endif


#define BD_LOG_MACRO(isAsynchronous, lvl, flg, ctx, atag, fnct, frmt, ...) \
[BDLog log : isAsynchronous                                     \
level : lvl                                                \
flag : flg                                                \
context : ctx                                                \
file : __FILE__                                           \
function : fnct                                               \
line : __LINE__                                           \
tag : atag                                               \
format : (frmt), ## __VA_ARGS__]


#define BD_LOG_MAYBE(async, lvl, flg, ctx, tag, fnct, frmt, ...) \
do { if(lvl & flg) BD_LOG_MACRO(async, lvl, flg, ctx, tag, fnct, frmt, ##__VA_ARGS__); } while(0)


#define BDLogError(frmt, ...)   BD_LOG_MAYBE(NO,                BD_LOG_LEVEL_DEF, BDLogFlagError,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define BDLogWarn(frmt, ...)    BD_LOG_MAYBE(YES, BD_LOG_LEVEL_DEF, BDLogFlagWarning, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define BDLogInfo(frmt, ...)    BD_LOG_MAYBE(YES, BD_LOG_LEVEL_DEF, BDLogFlagInfo,    0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define BDLogDebug(frmt, ...)   BD_LOG_MAYBE(YES, BD_LOG_LEVEL_DEF, (int)BDLogFlagDebug,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define BDLogVerbose(frmt, ...) BD_LOG_MAYBE(YES, BD_LOG_LEVEL_DEF, BDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)



@interface BDLog : NSObject

+ (void)log:(BOOL)synchronous
      level:(int)level
       flag:(int)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ...;

@end
