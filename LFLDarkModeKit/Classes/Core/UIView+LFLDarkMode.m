//
//  UIView+LFLDarkMode.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import "UIView+LFLDarkMode.h"
#import "UIColor+LFLDarkMode.h"
#import "LFLDarkModeTool.h"
#import <objc/runtime.h>

static void *layerBorderColorHexProperty = &layerBorderColorHexProperty;

@implementation UIView (LFLDarkMode)

+ (void)load {
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(traitCollectionDidChange:)),
                                   class_getInstanceMethod(self, @selector(traitCollectionDidChange_LFL:)));
}


- (void)traitCollectionDidChange_LFL:(UITraitCollection *)previousTraitCollection {
    [self traitCollectionDidChange_LFL:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection] && previousTraitCollection) {
            if (self.layer.borderWidth > 0) {
                UIColor *adpterBorderColor = [UIColor ColorAdpterWithHex:self.layerBorderColorHex];
                self.layer.borderColor = adpterBorderColor.CGColor;
                // 刷新layer 不一定会调用layoutSubViews
                [self.layer layoutIfNeeded];
            }
        }
    }
}

- (NSString *)layerBorderColorHex {
    
    return objc_getAssociatedObject(self, layerBorderColorHexProperty);
}

- (void)setLayerBorderColorHex:(NSString *)layerBorderColorHex {
    
    if ([LFLDarkModeTool isBlankHexString:layerBorderColorHex]) {
        return;
    }
    UIColor *currentBorderColor = [UIColor ColorAdpterWithHex:layerBorderColorHex];
    self.layer.borderColor = currentBorderColor.CGColor;
    objc_setAssociatedObject(self, layerBorderColorHexProperty, layerBorderColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
