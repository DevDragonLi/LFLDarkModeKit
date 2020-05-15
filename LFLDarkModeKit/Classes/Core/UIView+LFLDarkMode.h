//
//  UIView+LFLDarkMode.h
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// TODO ：add more support layers
@interface UIView (LFLDarkMode)

/// Config CaLayer BorderColor use Hex String
@property(nonatomic,copy)NSString *layerBorderColorHex;

/// Config CaLayer BackgroundColor use Hex String
@property(nonatomic,copy)NSString *layerBackgroundColorHex;

@end

NS_ASSUME_NONNULL_END
