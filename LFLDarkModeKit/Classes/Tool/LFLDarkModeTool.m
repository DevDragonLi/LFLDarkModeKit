//
//  LFLDarkModeTool.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/5.
//

#import "LFLDarkModeTool.h"
#import <objc/runtime.h>

@implementation LFLDarkModeTool

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleInstanceForClass:(Class)swizzleClass
                 originSelector:(SEL)originSelector
                replaceSelector:(SEL)replaceSelector {
    Method originMethod = class_getInstanceMethod(self, originSelector);
    Method replaceMethod = class_getInstanceMethod(self, replaceSelector);
    
    if (!originMethod || !replaceMethod) {
        return NO;
    }
    
    if (class_addMethod([swizzleClass class], originSelector, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))) {
        class_replaceMethod([swizzleClass class], replaceSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, replaceMethod);
    }
    
    return YES;
}


@end
