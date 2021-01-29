//
//  UIColor+LFLDarkMode.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//  HEX：https://github.com/shaojiankui/iOS-Categories

#import "UIColor+LFLDarkMode.h"
#import "LFLDarkModeManger.h"
#import "NSString+DarkModeKitBlank.h"

@implementation UIColor (LFLDarkMode)
/**
 * 1.color hex exapme: @"DEMO"  <==> 000000
 * 2.return current color Hex with DarkMode !
*/
+ (UIColor *)colorAdpterWithHex:(NSString *)colorHex alpha:(CGFloat)alpha {
    
    if (isEmptyString(colorHex)) {
        return nil;
    }
   
    if (@available(iOS 13.0,*)) {
        UIColor *currentShowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            NSString *hexString = [[LFLDarkModeManger sharedInstance] colorHexWithHexString:colorHex];
            return [UIColor colorFromHexString:hexString alpha:alpha];
        }];
        return currentShowColor;
    } else {
        NSString *hexString = [[LFLDarkModeManger sharedInstance] colorHexWithHexString:colorHex];
        return [UIColor colorFromHexString:hexString alpha:alpha];
    }
}

+ (UIColor *)colorAdpterWithHex:(NSString *)colorHex {
    return [self colorAdpterWithHex:colorHex alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)colorHexStr
                              alpha:(CGFloat)alpha {
    
    CGFloat R = 0.0,G = 0.0,B = 0.0,systemAlpha = 1.0;
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
