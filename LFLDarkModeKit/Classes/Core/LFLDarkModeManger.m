//
//  LFLDarkModeManger.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import "LFLDarkModeManger.h"
#import "NSString+DarkModeKitBlank.h"

static LFLDarkModeManger *darkModeMangerInstance = nil;

static dispatch_once_t onceToken;

static bool isFirstAccess = YES;

NSString *const darkPlistName = @"dark.plist";
NSString *const lightPlistName = @"light.plist";

@interface LFLDarkModeManger ()

@property (nonatomic, readwrite,getter=isDarkModeStyle) BOOL darkModeStyle;

@property (nonatomic, strong) NSDictionary * darkModeColorDic;

@property (nonatomic, strong) NSDictionary * lightModeColorDic;

@end

@implementation LFLDarkModeManger

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        darkModeMangerInstance = [[super allocWithZone:NULL] init];
        darkModeMangerInstance.darkModeStyle = [darkModeMangerInstance isDarkModeStyle];
        [darkModeMangerInstance darkModeMonitor];
    });
    return darkModeMangerInstance;
}

#pragma mark - Life Cycle

+ (instancetype)allocWithZone:(NSZone *)zone
{
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

+ (void)destroySharedInstance {
    onceToken = 0;
    darkModeMangerInstance = nil;
}

- (void)configDarkModeColorBundleName:(NSString *)bundleName {
    if (isEmptyString(bundleName)) {
        return;
    }
    
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *darkModePath = [bundlePath stringByAppendingPathComponent:darkPlistName];
    NSString *lightModePath = [bundlePath stringByAppendingPathComponent:lightPlistName];
    self.darkModeColorDic = [NSDictionary dictionaryWithContentsOfFile:darkModePath];
    self.lightModeColorDic = [NSDictionary dictionaryWithContentsOfFile:lightModePath];
}


- (BOOL)isDarkModeStyle {
    if (@available(iOS 13.0, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    } else {
        return NO;
    }
}

- (void)darkModeMonitor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 13.0, *)) {
            UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    self.darkModeStyle = YES;
                    NSLog(@"LFLDarkModeKitLog:DarkMode Now !");
                    return [UIColor blackColor];
                } else {
                    self.darkModeStyle = NO;
                    NSLog(@"LFLDarkModeKitLog: LightMode Now !");
                    return [UIColor grayColor];
                }
            }];
            UIView *unVisibleView = [[UIView alloc]initWithFrame:CGRectZero];
            unVisibleView.backgroundColor = dynamicColor;
            unVisibleView.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:unVisibleView];
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
    if (self.isDarkModeStyle) {
        return [self.darkModeColorDic objectForKey:hexString];
    } else {
        return [self.lightModeColorDic objectForKey:hexString];
    }
}

@end
