//
//  UIView+LFLDarkMode.m
//  LFLDarkModeKit
//
//  Created by LFL on 2020/5/4.
//

#import "UIView+LFLDarkMode.h"
#import "UIColor+LFLDarkMode.h"
#import "NSString+DarkModeKitBlank.h"
#import <objc/runtime.h>

static void *layerBorderColorHexProperty = &layerBorderColorHexProperty;

static void *layerBackgroundColorHexProperty = &layerBackgroundColorHexProperty;

@implementation UIView (LFLDarkMode)

+ (void)load {
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(traitCollectionDidChange:)),
                                   class_getInstanceMethod(self, @selector(environmentTraitCollectionDidChange:)));
}


- (void)environmentTraitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self environmentTraitCollectionDidChange:previousTraitCollection];
    
    if (@available(iOS 13.0, *)) {
        
        if (previousTraitCollection && [self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]){
            
            if (self.layerBorderColorHex) {
                UIColor *adpterBorderColor = [UIColor colorAdpterWithHex:self.layerBorderColorHex];
                self.layer.borderColor = adpterBorderColor.CGColor;
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


- (void)setLayerBorderColorHex:(NSString *)layerBorderColorHex {
    
    if (isEmptyString(layerBorderColorHex)) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        return;
    }
    
    UIColor *currentBorderColor = [UIColor colorAdpterWithHex:layerBorderColorHex];
    self.layer.borderColor = currentBorderColor.CGColor;
    objc_setAssociatedObject(self, layerBorderColorHexProperty, layerBorderColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setLayerBackgroundColorHex:(NSString *)layerBackgroundColorHex {
    
    if (isEmptyString(layerBackgroundColorHex)) {
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        return;
    }
    
    UIColor *layerBackgroundColor = [UIColor colorAdpterWithHex:layerBackgroundColorHex];
    self.layer.backgroundColor = layerBackgroundColor.CGColor;
    objc_setAssociatedObject(self, layerBackgroundColorHexProperty, layerBackgroundColorHex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)layerBackgroundColorHex {
    
    return objc_getAssociatedObject(self, layerBackgroundColorHexProperty);
}

- (NSString *)layerBorderColorHex {
    
    return objc_getAssociatedObject(self, layerBorderColorHexProperty);
}

@end
