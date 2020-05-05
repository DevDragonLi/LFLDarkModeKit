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

static void *layerBackgroundColorHexProperty = &layerBackgroundColorHexProperty;

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
                
            }
            if (self.layer.backgroundColor) {
                UIColor *layerBackgroundColor = [UIColor ColorAdpterWithHex:self.layerBackgroundColorHex];
                self.layer.backgroundColor = layerBackgroundColor.CGColor;
            }
            // 刷新layer 不一定会调用layoutSubViews
            [self.layer layoutIfNeeded];
        }
    }
}


#pragma mark --------------------------------------------------------------------------------------


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

- (NSString *)layerBackgroundColorHex {
    
    return objc_getAssociatedObject(self, layerBackgroundColorHexProperty);
}

- (void)setLayerBackgroundColorHex:(NSString *)layerBackgroundColorHex {
    
    if ([LFLDarkModeTool isBlankHexString:layerBackgroundColorHex]) {
        return;
    }
    UIColor *layerBackgroundColor = [UIColor ColorAdpterWithHex:layerBackgroundColorHex];
    self.layer.backgroundColor = layerBackgroundColor.CGColor;
    objc_setAssociatedObject(self, layerBackgroundColorHexProperty, layerBackgroundColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
