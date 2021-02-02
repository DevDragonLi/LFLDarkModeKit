//
//  UIWindow+DarkModeKitKeyWondow.m
//  LFLDarkModeKit
//
//  Created by SmallKing on 2021/2/2.
//

#import "UIWindow+DarkModeKitKeyWondow.h"

@implementation UIWindow (DarkModeKitKeyWondow)

+ (UIWindow *)lfl_keyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                        break;
                    }
                }
            }
        }
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
    
    return nil;
}

@end
