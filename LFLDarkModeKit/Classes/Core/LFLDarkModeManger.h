//
//  LFLDarkModeManger.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFLDarkModeManger : NSObject

///current darkModeStyle
@property (nonatomic, readonly,getter=isDarkModeStyle) BOOL darkModeStyle;

/**
 * darkModeManger
 */
+ (instancetype)sharedInstance;

/**
 * destroy the LFLDarkModeManger object free sources
 */
+ (void )destroySharedInstance;

- (instancetype)init __attribute__((unavailable("Disabled !!! Please Use +sharedInstance instead")));

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
