//
//  NSString+Blank.h
//  LFLDarkModeKit
//
//  Created by admin on 14/6/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define isEmptyString(string) [NSString lflIsBlankString:string]

@interface NSString (LFLBlank)

/// check String
+ (BOOL)lflIsBlankString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
