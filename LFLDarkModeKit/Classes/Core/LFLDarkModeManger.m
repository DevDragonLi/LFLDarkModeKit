//
//  LFLDarkModeManger.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import "LFLDarkModeManger.h"
#import "LFLDarkModeTool.h"

@interface LFLDarkModeManger ()

@property (nonatomic, readwrite,getter=isDarkModeStyle) BOOL darkModeStyle;

@property (nonatomic, strong) NSDictionary * darkModeColorDic;

@property (nonatomic, strong) NSDictionary * lightModeColorDic;

@end

@implementation LFLDarkModeManger

+ (instancetype)sharedInstance {
    static LFLDarkModeManger *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[LFLDarkModeManger alloc]init];
        instance.darkModeStyle = [instance isDarkModeStyle];
    });
    return instance;
}

- (void)configDarkModeColorBundleName:(NSString *)bundleName {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self darkModeMonitor];
        [self loadDarkModeColorWithBundleName:bundleName];
    });
}

- (void)loadDarkModeColorWithBundleName:(NSString *)bundleName{
    if ([LFLDarkModeTool isBlankHexString:bundleName]) {
        return;
    }
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *darkModePath = [bundlePath stringByAppendingPathComponent:@"dark.plist"];
    NSString *lightModePath = [bundlePath stringByAppendingPathComponent:@"light.plist"];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 13.0, *)) {
            UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    self.darkModeStyle = YES;
                    NSLog(@"LFLDarkModeKitLog:当前主题为暗黑模式");
                    return [UIColor blackColor];
                } else {
                    self.darkModeStyle = NO;
                    NSLog(@"LFLDarkModeKitLog:当前主题为正常模式");
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
 * 需要内部判断当前的暗黑模式来处理颜色
 * iOS13：动态返回，iOS13以下则固定light表查值
 */
- (NSString *)colorHexWithHexString:(NSString *)hexString {
    if ([LFLDarkModeTool isBlankHexString:hexString]) {
        return nil;
    }
    if (self.isDarkModeStyle) {
        return [self.darkModeColorDic objectForKey:hexString];
    } else {
        return [self.lightModeColorDic objectForKey:hexString];
    }
}

@end
