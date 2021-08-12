//
//  LFLDarkModeManger.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import "LFLDarkModeManger.h"
#import "NSString+DarkModeKitBlank.h"
#import "UIWindow+DarkModeKitKeyWondow.h"

typedef enum : NSUInteger {
    lightMode = 0,
    darkMode = 1,
    unKnowMode = -1024,
} LFLModeStyle;

static LFLDarkModeManger *darkModeMangerInstance = nil;

static dispatch_once_t onceToken;

static bool isFirstAccess = YES;

NSString * _Nonnull const darkPlistName = @"dark.plist";

NSString * _Nonnull const lightPlistName = @"light.plist";

NSString * _Nonnull const LFLDarkModeChangeNotification = @"LFLDarkModeChangeNotificationKey";

NSString * _Nonnull const LFLDarkModeChangeNotificationKey = @"LFLDarkModeKey";

@interface LFLDarkModeManger ()

@property (nonatomic, readwrite,getter=isDarkModeStyle) BOOL darkModeStyle;

@property (nonatomic, assign) BOOL customDarkModeStyle;

@property (nonatomic, assign) BOOL customDarkMode;

@property (nonatomic, strong) NSDictionary * darkModeColorDic;

@property (nonatomic, strong) NSDictionary * lightModeColorDic;

@property (nonatomic, assign) BOOL isMonitorLoaded;

@end

@implementation LFLDarkModeManger

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        darkModeMangerInstance = [[super allocWithZone:NULL] init];
        [darkModeMangerInstance configCurrentMode];
        [darkModeMangerInstance darkModeMonitor];
    });
    return darkModeMangerInstance;
}

#pragma mark - Life Cycle

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copy {
    return [[LFLDarkModeManger alloc] init];
}

- (instancetype)mutableCopy {
    return [[LFLDarkModeManger alloc] init];
}

- (instancetype)init {
    if(darkModeMangerInstance){
        return darkModeMangerInstance;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}

#pragma mark --- mode value 

- (BOOL)isUserDarkMode {
    return self.customDarkMode;
}

- (void)configUserDarkMode:(BOOL)status {
    if (_customDarkMode == status) {
        return;
    } else {
        _customDarkMode = status;
        _customDarkModeStyle = YES;
        [[LFLDarkModeManger sharedInstance] postDarkModeChangeNotificationName];
    }
}

- (BOOL)isDarkModeStyle {
    if (self.customDarkModeStyle) {
        return self.customDarkMode;
    } else {
        if (@available(iOS 13.0, *)) {
            return _darkModeStyle;
        } else {
            return NO;
        }
    }
}

- (void)configCurrentMode {
    
    if (@available(iOS 13.0, *)) {
        UIView *unVisibleView = [[UIView alloc]initWithFrame:CGRectZero];
        unVisibleView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                self.darkModeStyle = darkMode;
            } else {
                self.darkModeStyle = lightMode;
            }
            NSLog(@"只走了一次");
            return UIColor.whiteColor;
        }];
    } else {
        self.darkModeStyle = lightMode;
    }
}

- (void)configDarkModeColorBundleURL:(nullable NSURL *)bundleURL {
    if (isEmptyString(bundleURL.path)) {
        return;
    }
    NSURL *darkModeURL = [bundleURL URLByAppendingPathComponent:darkPlistName];
    NSURL *lightModeURL = [bundleURL URLByAppendingPathComponent:lightPlistName];
    
    NSError *darkModeLoadError;
    
    if (@available(iOS 11.0, *)) {
        
        self.darkModeColorDic = [NSDictionary dictionaryWithContentsOfURL:darkModeURL error:&darkModeLoadError];
        
        NSAssert1(!darkModeLoadError.userInfo, @"【LFLDarkModeKitTips Debug Msg】%@", darkModeLoadError.userInfo);
        
        self.lightModeColorDic = [NSDictionary dictionaryWithContentsOfURL:lightModeURL error:&darkModeLoadError];
        
        NSAssert1(!darkModeLoadError.userInfo, @"【LFLDarkModeKitTips Debug Msg】%@", darkModeLoadError.userInfo);
    } else {
        self.darkModeColorDic = [NSDictionary dictionaryWithContentsOfURL:darkModeURL];
        self.lightModeColorDic = [NSDictionary dictionaryWithContentsOfURL:lightModeURL];
    }
}

- (void)postDarkModeChangeNotificationName {
    if (self.isMonitorLoaded) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LFLDarkModeChangeNotification object:@{LFLDarkModeChangeNotificationKey:@([self isDarkModeStyle])}];
    }
}

- (void)updateMonitorStatus {
    if (!self.isMonitorLoaded) {
        self.isMonitorLoaded = YES;
    }
}

- (void)darkModeMonitor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 13.0, *)) {
            UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    self.darkModeStyle = YES;
                    [self postDarkModeChangeNotificationName];
                    [self updateMonitorStatus];
                    NSLog(@"\n😄 DarkMode Now ! \n😄【LFLDarkModeKitTips Debug Msg】");
                    return [UIColor blackColor];
                } else {
                    self.darkModeStyle = NO;
                    [self postDarkModeChangeNotificationName];
                    [self updateMonitorStatus];
                    NSLog(@"\n😄 LightMode Now ! \n😄 【LFLDarkModeKitTips Debug Msg】");
                    return [UIColor grayColor];
                }
            }];
            UIView *unVisibleView = [[UIView alloc]initWithFrame:CGRectZero];
            unVisibleView.backgroundColor = dynamicColor;
            unVisibleView.hidden = YES;
            UIWindow *keyWindow = [UIWindow lfl_keyWindow];
            if (keyWindow) {
                [keyWindow addSubview:unVisibleView];
            } else {
                NSAssert(0,@"⚠️⚠️⚠️：keyWindow  Error【LFLDarkModeKitTips Debug Msg】");
            }
        }
    });
}
/*
 * iOS13 + :dynamic value
 * iOS13 - :static value (lightModeColor)
 */
- (NSString *)colorHexWithHexString:(NSString *)hexString {
    if (isEmptyString(hexString)) {
        return nil;
    }
    if ([self isDarkModeStyle]) {
        return [self.darkModeColorDic objectForKey:hexString];
    } else {
        return [self.lightModeColorDic objectForKey:hexString];
    }
}

- (void)destroySharedInstance {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        onceToken = 0;
        darkModeMangerInstance = nil;
    });
}

@end
