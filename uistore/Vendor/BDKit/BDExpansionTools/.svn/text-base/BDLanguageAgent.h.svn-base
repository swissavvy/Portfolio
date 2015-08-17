//
//  LanguageHelper.h
//  qeebuConference
//
//  Created by hanson on 11/25/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LanguageEnglish,
    LanguageZhHans,
    LanguageZhHant
}LanguageType;

#define BD_LOC(str, comment) [LanguageHelper  get:str alter:nil]

@interface BDLanguageAgent : NSObject

//+ (void)initialize;
+ (void)setLanguage:(NSString *)lan;
+ (NSString *)get:(NSString *)key alter:(NSString *)alternate;

+ (NSString *)currentLanguage;
+ (LanguageType)currentLanguageType;

@end
