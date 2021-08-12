//
//  LFLDarkModeManger.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <Foundation/Foundation.h>

/// When the APP switches theme mode, it throws a Notification
FOUNDATION_EXTERN NSString * _Nonnull const LFLDarkModeChangeNotification;

/// APP Theme mode Changed  throws NotificationKey
FOUNDATION_EXTERN NSString * _Nonnull const LFLDarkModeChangeNotificationKey;

NS_ASSUME_NONNULL_BEGIN

@interface LFLDarkModeManger : NSObject

///Current System DarkModeStyle
@property (nonatomic, readonly,getter=isDarkModeStyle) BOOL darkModeStyle;

/**
 * darkModeManger
 */
+ (instancetype)sharedInstance;

/// userDarkModeStyle   【Default is NO】
- (BOOL)isUserDarkMode;

/// Setting  userDarkModeStyle
- (void)configUserDarkMode:(BOOL)status;

- (instancetype)init __attribute__((unavailable("Disabled !!! Please Use +sharedInstance instead")));

/// NOTE：darkMode config Plist bundleURL
- (void)configDarkModeColorBundleURL:(nullable NSURL *)bundleURL;

/**
 * dynamicTransform  Color Value  < ==>
 * DarkMode : input @"PColor0"   return  FFFFFF
 * LightMode : input @"PColor0"   return  000000
 */
- (NSString *)colorHexWithHexString:(NSString *)hexString;

/**
 * destroy the LFLDarkModeManger object free sources
 */
- (void )destroySharedInstance;

@end

NS_ASSUME_NONNULL_END
