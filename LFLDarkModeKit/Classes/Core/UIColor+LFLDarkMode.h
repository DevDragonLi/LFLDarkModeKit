//
//  UIColor+LFLDarkMode.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

/// Tips: if Need it ,in You PCH or Define

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//#define LFLAdpterColor(hexColorString)   [UIColor colorAdpterWithHex:hexColorString]

//#define LFLAdpterColorAlpha(hexColorString, alpha)  [UIColor colorAdpterWithHex:hexColorString alpha:alpha]

@interface UIColor (LFLDarkMode)

/// adpter darkMode WithHexString
/// @param colorHex colorHex
+ (nullable UIColor *)colorAdpterWithHex:(NSString *)colorHex;

/// adpter darkMode WithHexString
/// @param colorHex colorHex
/// @param alpha alpha
+ (nullable UIColor *)colorAdpterWithHex:(NSString *)colorHex
                          alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
