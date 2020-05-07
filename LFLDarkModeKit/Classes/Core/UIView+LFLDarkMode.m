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
    [LFLDarkModeTool swizzleInstanceForClass:[self class] originSelector:@selector(traitCollectionDidChange:) replaceSelector:@selector(environmentTraitCollectionDidChange:)];
}

- (void)environmentTraitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self environmentTraitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection] && previousTraitCollection) {
            if (self.layer.borderWidth > 0) {
                UIColor *adpterBorderColor = [UIColor colorAdpterWithHex:self.layerBorderColorHex];
                self.layer.borderColor = adpterBorderColor.CGColor;
                [self.layer layoutIfNeeded];
            }
            if (self.layerBackgroundColorHex) {
                UIColor *layerBackgroundColor = [UIColor colorAdpterWithHex:self.layerBackgroundColorHex];
                self.layer.backgroundColor = layerBackgroundColor.CGColor;
            }
            [self.layer layoutIfNeeded];
        }
    }
}


#pragma mark --------------------------------------------------------------------------------------


- (NSString *)layerBorderColorHex {
    
    return objc_getAssociatedObject(self, layerBorderColorHexProperty);
}

- (void)setLayerBorderColorHex:(NSString *)layerBorderColorHex {
    
    if ([LFLDarkModeTool isBlankString:layerBorderColorHex]) {
        return;
    }
    UIColor *currentBorderColor = [UIColor colorAdpterWithHex:layerBorderColorHex];
    self.layer.borderColor = currentBorderColor.CGColor;
    objc_setAssociatedObject(self, layerBorderColorHexProperty, layerBorderColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)layerBackgroundColorHex {
    
    return objc_getAssociatedObject(self, layerBackgroundColorHexProperty);
}

- (void)setLayerBackgroundColorHex:(NSString *)layerBackgroundColorHex {
    
    if ([LFLDarkModeTool isBlankString:layerBackgroundColorHex]) {
        return;
    }
    UIColor *layerBackgroundColor = [UIColor colorAdpterWithHex:layerBackgroundColorHex];
    self.layer.backgroundColor = layerBackgroundColor.CGColor;
    objc_setAssociatedObject(self, layerBackgroundColorHexProperty, layerBackgroundColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
