//
//  NSString+DarkModeKitBlank.m
//  LFLDarkModeKit
//
//  Created by LFL on 14/6/2020.
//

#import "NSString+DarkModeKitBlank.h"

@implementation NSString (DarkModeKitBlank)

+ (BOOL)darkModeKit_BlankString:(nullable NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    
    return NO;
}

@end
