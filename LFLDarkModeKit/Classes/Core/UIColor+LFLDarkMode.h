//
//  UIColor+LFLDarkMode.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LFLDarkMode)


+ (UIColor *)ColorAdpterWithHex:(NSString *)colorHex;

+ (UIColor *)ColorAdpterWithHex:(NSString *)colorHex
                          alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
