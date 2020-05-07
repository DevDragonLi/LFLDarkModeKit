//
//  LFLDarkModeTool.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFLDarkModeTool : NSObject

/// check String 
+ (BOOL)isBlankString:(NSString *)string;

/// swizzleInstanceMethod
+ (BOOL)swizzleInstanceForClass:(Class)swizzleClass
                 originSelector:(SEL)originSelector
                replaceSelector:(SEL)replaceSelector;

@end

NS_ASSUME_NONNULL_END
