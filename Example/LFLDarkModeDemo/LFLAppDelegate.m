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
    [[LFLDarkModeManger sharedInstance] configDarkModeColorBundleName:@"darkModeAdapterColor"];
    
    [LFLDarkModeManger.sharedInstance configUserDarkMode:NO];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    [LFLDarkModeManger.sharedInstance destroySharedInstance];
}



@end
