//
//  UIImage+LFLDarkMode.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LFLDarkMode)

/**
 * NOTE : Images.xcassets Setting  (Appearances : any dark)
 * Adapter DarkMode If Need
 */
+ (nullable UIImage *)imageAdapterNamed:(NSString *)xcassetsName;

@end

NS_ASSUME_NONNULL_END
