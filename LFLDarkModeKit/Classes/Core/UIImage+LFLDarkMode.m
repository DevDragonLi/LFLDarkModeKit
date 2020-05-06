//
//  UIImage+LFLDarkMode.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/6.
//

#import "UIImage+LFLDarkMode.h"
#import "LFLDarkModeTool.h"

@implementation UIImage (LFLDarkMode)

+ (nullable UIImage *)imageAdapterNamed:(NSString *)xcassetsName {
    if ([LFLDarkModeTool isBlankString:xcassetsName]) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:xcassetsName];
    if (@available(iOS 13.0, *)) {
        if (!image) {
            image = [UIImage systemImageNamed:xcassetsName];
        }
    }
    return image;
}

@end
