//
//  LFLViewController.m
//  LFLDarkModeKit
//
//  Created by DevDragonli on 05/04/2020.
//  Copyright (c) 2020 DevDragonli. All rights reserved.
//

#import "LFLViewController.h"
#import <LFLDarkModeKit.h>

@interface LFLViewController ()

/// xib ImageView adapter dark mode
@property (weak, nonatomic) IBOutlet UIImageView *exampleImageView;
/// ImageView
@property (strong, nonatomic) UIImageView *adapterImageView;
/// CALayer adapter dark mode
@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;

@property (weak, nonatomic) IBOutlet UIButton *exampleButton;

@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation LFLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configTestViews];
}

/// 常见UI标准组件 
- (void)configTestViews {
    
    UIColor *dyColor = [UIColor colorAdpterWithHex:@"DEMO"];
    
#pragma mark 1. UIImageView : xib/story Images.xcassets方式采取系统自动适配
    
#pragma mark 2. UIView
    
    /*
     UIView及自定义View存在圆角的情况下，CALayer层动态颜色处理
     Apple的API不包含动态CGColor，需要对应视图各个实现traitCollectionDidChange回调处理！）
     */
    self.customView.layer.cornerRadius = 50.0f;
    self.customView.layer.borderWidth = 20.0f;
    self.customView.layerBorderColorHex = @"DEMO";
    
#pragma mark 3. UILabel
    //  support：textColor，backgroundColor,highlightedTextColor
    self.exampleLabel.textColor = dyColor;
    //    self.exampleLabel.backgroundColor = dyColor;
    //    self.exampleLabel.highlightedTextColor = dyColor;
#pragma mark 4.  UIButton
    self.exampleButton.backgroundColor = dyColor;
    //    self.exampleButton.layer.cornerRadius = 10.0f;
    //    self.exampleButton.layer.borderWidth = 8.0f;
    //    self.exampleButton.layerBorderColorHex = @"DEMO";
    //    [self.exampleButton setTitleColor:dyColor forState:UIControlStateSelected|UIControlStateHighlighted];
}

@end
