//
//  LFLDarkModeManger.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFLDarkModeManger : NSObject

@property (nonatomic, readonly,getter=isDarkModeStyle) BOOL darkModeStyle;

+ (instancetype)sharedInstance;

/// NOTE：初始化当前暗黑组件色值bundle名称
- (void)configDarkModeColorBundleName:(NSString *)bundleName;

/// 查询项目的HEX自定义字符串转化为当前模式下真实的hex色值: @"DEMO"  < > F5F5F5 0.0

- (NSString *)colorHexWithHexString:(NSString *)hexString;


@end

NS_ASSUME_NONNULL_END
