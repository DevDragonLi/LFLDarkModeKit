//
//  LFLDarkModeTool.h
//  LFLDarkModeDemo_Example
//
//  Created by SmallKing on 2021/2/3.
//  Copyright © 2021 DevDragonli. All rights reserved.
//

/**
                            Use
 
 1. 项目中 定义好各类颜色对应的Key ：例如 PColor0 。。。
 2. 可以使用宏定义或者函数去构建常用色值。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 【色值Key 】
@interface LFLDarkModeTool : NSObject

/// Light Mode 白色 && DarkMode 黑色
+ (NSString *)PColor0String;

@end

NS_ASSUME_NONNULL_END
