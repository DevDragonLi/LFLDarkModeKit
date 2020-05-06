//
//  LFLDarkModeManger.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface LFLDarkModeManger : NSObject

@property (nonatomic, readonly,getter=isDarkModeStyle) BOOL darkModeStyle;

+ (instancetype)sharedInstance;

/// NOTE：darkMode config Plist bundle Name
- (void)configDarkModeColorBundleName:(NSString *)bundleName;

/**
 * dynamicTransform  Color Value  < ==>
 * DarkMode : input @"DEMO"   return  FFFFFF
 * LightMode : input @"DEMO"   return  000000 
 */
- (NSString *)colorHexWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
