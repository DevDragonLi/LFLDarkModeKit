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
    [self LFLDarkModeMangerDemo];
    
    return YES;
}

- (void)LFLDarkModeMangerDemo {
    
    NSURL *darkModeBundleURL = [[NSBundle mainBundle] URLForResource:@"darkModeAdapterColor" withExtension:@"bundle"];
    [[LFLDarkModeManger sharedInstance] configDarkModeColorBundleURL:darkModeBundleURL];
     
     [LFLDarkModeManger.sharedInstance configUserDarkMode:NO];
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    [LFLDarkModeManger.sharedInstance destroySharedInstance];
}



@end
