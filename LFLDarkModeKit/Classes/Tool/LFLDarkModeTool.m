//
//  LFLDarkModeTool.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/5.
//

#import "LFLDarkModeTool.h"

@implementation LFLDarkModeTool

+ (BOOL)isBlankString:(NSString *)string {
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
