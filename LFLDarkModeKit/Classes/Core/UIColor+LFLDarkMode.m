//
//  UIColor+LFLDarkMode.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//
/*
 HEX：https://github.com/shaojiankui/iOS-Categories
 Example : 正常：白色，暗黑：灰色
 */

#import "UIColor+LFLDarkMode.h"
#import "LFLDarkModeManger.h"
#import "LFLDarkModeTool.h"

@implementation UIColor (LFLDarkMode)

+ (UIColor *)ColorAdpterWithHex:(NSString *)colorHex alpha:(CGFloat)alpha {
    
    if ([LFLDarkModeTool isBlankHexString:colorHex]) {
        return nil;
    }
    /*
     逻辑：
     1.根据colorHex 获取当前色值表中对应的色值 hex exapme: @"DEMO"  < > 000000
     2.根据当前是否暗黑模式来返回正确的UIColor
     */
    if (@available(iOS 13.0,*)) {
        UIColor *currentShowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            NSString *hexString = [[LFLDarkModeManger sharedInstance] colorHexWithHexString:colorHex];
            return [UIColor ARGBColorFromHexString:hexString alpha:alpha];
        }];
        return currentShowColor;
    } else {
        NSString *hexString = [[LFLDarkModeManger sharedInstance] colorHexWithHexString:colorHex];
        return [UIColor ARGBColorFromHexString:hexString alpha:alpha];
    }
}

+ (UIColor *)ColorAdpterWithHex:(NSString *)colorHex {
    return [self ColorAdpterWithHex:colorHex alpha:1.0];
}

+ (UIColor *)ARGBColorFromHexString:(NSString *)colorHexStr
                              alpha:(CGFloat)alpha {
    CGFloat R = 0.0;
    CGFloat G = 0.0;
    CGFloat B = 0.0;
    
    CGFloat systemAlpha = 1.0;
    NSUInteger index = 0;
    if (colorHexStr.length == 8) {
        alpha = [self colorValueFromHexString:[colorHexStr substringWithRange:NSMakeRange(0, 2)]];
        index = 2;
    }
    
    R = [self colorValueFromHexString:[colorHexStr substringWithRange:NSMakeRange(index, 2)]];
    G = [self colorValueFromHexString:[colorHexStr substringWithRange:NSMakeRange(index + 2, 2)]];
    B = [self colorValueFromHexString:[colorHexStr substringWithRange:NSMakeRange(index + 4, 2)]];
    
    return [UIColor colorWithRed:R green:G blue:B alpha:systemAlpha * alpha];
}

//16进制颜色值与浮点型颜色值的转换
+ (CGFloat)colorValueFromHexString:(NSString *)hexString {
    int num[2] = {0};
    for (int i = 0 ; i < 2; i++) {
        int asc = [hexString characterAtIndex:i];
        
        if (asc >= '0' && asc <= '9') {
            num[i] = asc - '0';
        }
        else if (asc >= 'A' && asc <= 'F') {
            num[i] = asc - 'A' + 10;
        }
        else if (asc >= 'a' && asc <= 'f') {
            num[i] = asc - 'a' + 10;
        }
    }
    return (num[0] * 16 + num[1]) / 255.;
}

@end
