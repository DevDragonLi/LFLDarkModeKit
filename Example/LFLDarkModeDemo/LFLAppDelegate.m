//
//  LFLAppDelegate.m
//  LFLDarkModeDemo
//
//  Created by DevDragonli on 05/04/2020.
//  Copyright (c) 2020 DevDragonli. All rights reserved.
//

#import "LFLAppDelegate.h"
#import <LFLDarkModeKit/LFLDarkModeKit.h>

@implementation LFLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configDarkModeSettings];
    
    return YES;
}

/**
 * 配置暗黑组件
 */
- (void)configDarkModeSettings {
    /**
     `暗黑配置资源文件`
     1. 小型项目  放置主工程即可
     2. 中/大/航母级项目组件化开发模式下: 建议适配层组件托管处理（Example：XXXDarkModeService ）内部配置常用色值String（参考LFLDarkModeTool）等
     */
    
    NSURL *darkModeBundleURL = [[NSBundle mainBundle] URLForResource:@"darkModeAdapterColor" withExtension:@"bundle"];
    [LFLDarkModeManger.sharedInstance configDarkModeColorBundleURL:darkModeBundleURL];
    if (LFLDarkModeManger.sharedInstance.isDarkModeStyle) {
        NSLog(@"Launch：DarkModeStyle");
    } else {
        NSLog(@"Launch：LightModeStyle");
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    [LFLDarkModeManger.sharedInstance destroySharedInstance];
}

@end
