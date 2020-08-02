//
//  NSString+Blank.m
//  LFLDarkModeKit
//
//  Created by admin on 14/6/2020.
//

#import "NSString+Blank.h"

@implementation NSString (LFLBlank)

+ (BOOL)lflIsBlankString:(NSString *)string {
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
