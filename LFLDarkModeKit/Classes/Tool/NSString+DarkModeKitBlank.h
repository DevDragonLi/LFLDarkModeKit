//
//  NSString+DarkModeKitBlank.h
//  LFLDarkModeKit
//
//  Created by LFL on 14/6/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define isEmptyString(string) [NSString darkModeKit_BlankString:string]

@interface NSString (DarkModeKitBlank)

/// Check String is Empty 

+ (BOOL)darkModeKit_BlankString:(nullable NSString *)string;

@end

NS_ASSUME_NONNULL_END
