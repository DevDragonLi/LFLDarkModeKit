//
//  LFLDarkModeTool.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/5.
//

#import "LFLDarkModeTool.h"

@implementation LFLDarkModeTool

+ (BOOL)isBlankHexString:(NSString *)layerBorderColorHex {
    if (layerBorderColorHex == nil || layerBorderColorHex == NULL) {
        return YES;
    }
    if ([layerBorderColorHex isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([layerBorderColorHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}



@end
