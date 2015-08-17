//
//  BDMacro.h
//  BDKit
//
//  Created by Liu Jinyong on 14-2-20.
//  Copyright (c) 2014年 Bodong Baidu. All rights reserved.
//

// Common

#define FORMAT(string, args...) [NSString stringWithFormat:string, args]

#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define JSON_EXCLUDE_NULL(x)        [[x stringByReplacingOccurrencesOfString : @":null" withString : @":\"\""] stringByReplacingOccurrencesOfString : @":NaN" withString : @":\"0\""]

// String

#define STR_FROM_INT(__X__) [NSString stringWithFormat:@"%d", __X__]
#define STR_FROM_DOUBLE(__X__) [NSString stringWithFormat:@"%f", __X__]

// Degree

#define DEGREES_TO_RADIANS(degrees) (degrees) * M_PI / 180


// UserDefaults

#define PROPERTY_OBJECT_USER_DEFAULT(accessor, mutator, key) \
USER_DEFAULT_ACCESSOR (accessor, key) \
USER_DEFAULT_MUTATOR (mutator, key)

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define USER_DEFAULT_ACCESSOR(accessor, key) \
- (id)accessor { \
return [[NSUserDefaults standardUserDefaults] objectForKey:key];  \
}

#define USER_DEFAULT_MUTATOR(mutator, key) \
- (void)mutator:(id)value { \
[[NSUserDefaults standardUserDefaults] setObject:value forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize];    \
}


// Associated

#define ASSOCIATED(propertyName, setter, type, objc_AssociationPolicy)\
- (type)propertyName {\
return objc_getAssociatedObject(self, _cmd);\
}\
\
- (void)setter:(type)object\
{\
objc_setAssociatedObject(self, @selector(propertyName), object, objc_AssociationPolicy);\
}


// UserDefaults C type

#define PROPERTY_BOOL_USER_DEFAULT(accessor, mutator, key) \
USER_DEFAULT_MUTATOR_CTYPE (mutator, key, BOOL) \
- (BOOL)accessor {return [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];}

#define PROPERTY_INT_USER_DEFAULT(accessor, mutator, key) \
USER_DEFAULT_MUTATOR_CTYPE (mutator, key, int) \
- (int)accessor {return [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue];}

#define PROPERTY_FLOAT_USER_DEFAULT(accessor, mutator, key) \
USER_DEFAULT_MUTATOR_CTYPE (mutator, key, float) \
- (float)accessor {return [[[NSUserDefaults standardUserDefaults] objectForKey:key] floatValue];}

#define PROPERTY_ENUM_USER_DEFAULT(accessor, mutator, key, type) \
USER_DEFAULT_MUTATOR_CTYPE (mutator, key, type) \
- (type)accessor {return [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue];}

#define USER_DEFAULT_MUTATOR_CTYPE(mutator, key, type) \
- (void)mutator:(type)value { \
[[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize];    \
}



// BDTipWindow

#define HIDE_HUD [[BDTipWindow sharedInstance] hideProgressHUD:YES]

#define SHOW_LOADING_HUD(_MSG_) [[BDTipWindow sharedInstance] showProgressHUDWithMessage:_MSG_]

#define SHOW_SUCCESS_HUD(_MSG_) [[BDTipWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_success"]]

#define SHOW_ERROR_HUD(_MSG_) [[BDTipWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_failed"]]

#define SHOW_WARNING_HUD(_MSG_) [[BDTipWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_warning"]]



// Delegate

#define DELEGATE_CALLBACK(DELEGATE, SEL) if (DELEGATE && [DELEGATE respondsToSelector:@selector(SEL)]) [DELEGATE performSelector:@selector(SEL)]

#define DELEGATE_CALLBACK_ONE_PARAMETER(DELEGATE, SEL, X) if (DELEGATE && [DELEGATE respondsToSelector:@selector(SEL)]) [DELEGATE performSelector:@selector(SEL) withObject:X]

#define DELEGATE_CALLBACK_TWO_PARAMETER(DELEGATE, SEL, X, Y) if (DELEGATE && [DELEGATE respondsToSelector:@selector(SEL)]) [DELEGATE performSelector:@selector(SEL) withObject:X withObject:Y]

#define DELEGATE_CALLBACK_ARRAY(__delegate__, __SEL__, __array__) \
if (__delegate__ && [__delegate__ respondsToSelector:@selector(__SEL__)]) { \
[[NSInvocation invocationWithTarget:__delegate__ selector:@selector(__SEL__) argumentArray:(__array__)] invoke]; \
}

#define DELEGATE_CALLBACK_PARAMETERS(__delegate__, __SEL__, args...) \
if (__delegate__ && [__delegate__ respondsToSelector:@selector(__SEL__)]) { \
NSInvocation *invocation = [NSInvocation invocationWithTarget:delegate selector:@selector(__SEL__) arguments:args]; \
[invocation invoke]; \
}

#define DELEGATE_DELAY_CALLBACK_PARAMETERS(__delegate__, __DELAY__, __SEL__, args...) \
if (__delegate__ && [__delegate__ respondsToSelector:@selector(__SEL__)]) { \
NSInvocation *invocation = [NSInvocation invocationWithTarget:delegate selector:@selector(__SEL__) arguments:args]; \
[invocation performSelector:@selector(invoke) withObject:nil afterDelay:__DELAY__];\
}

// System

#define IOS8_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IOS7_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS6_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define IOS5_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending)
#define IOS4_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending)
#define IOS3_OR_LATER	([[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending)


// Safe releases

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define INVALIDATE_TIMER(__TIMER) {if([__TIMER isValid]) {[__TIMER invalidate]; __TIMER = nil;} }


// UIColor

#define RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define RGB_HEX(V)		[UIColor colorWithHexValue:V]

#define RGBA_HEX(V, A)	[UIColor colorWithHexValue:V alpha:A]

#define RGB_SHORT(V)	[UIColor colorWithShortHexValue:V]

// UIView

#define UIViewAutoresizingFlexibleWidthAndHeight UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight


// UIText

#ifdef __IPHONE_6_0

#define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
#define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
#define UILineBreakModeClip				NSLineBreakByClipping
#define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
#define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

#define UITextAlignmentLeft				NSTextAlignmentLeft
#define UITextAlignmentCenter			NSTextAlignmentCenter
#define UITextAlignmentRight			NSTextAlignmentRight

#endif	// #ifdef __IPHONE_6_0


// ARC

#if defined(__has_feature) && __has_feature(objc_arc_weak)
#define BD_WEAK weak
#define BD_STRONG strong
#elif defined(__has_feature)  && __has_feature(objc_arc)
#define BD_WEAK unsafe_unretained
#define BD_STRONG retain
#else
#define BD_WEAK assign
#define BD_STRONG retain
#endif


// Category
#define BD_FIX_CATEGORY_BUG(name) @interface BD_FIX_CATEGORY_BUG_##name : NSObject @end \
@implementation BD_FIX_CATEGORY_BUG_##name @end





