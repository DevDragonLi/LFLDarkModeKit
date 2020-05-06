//
//  LFLViewController.m
//  LFLDarkModeKit
//
//  Created by DevDragonli on 05/04/2020.
//  Copyright (c) 2020 DevDragonli. All rights reserved.
//

#import "LFLViewController.h"
#import <LFLDarkModeKit.h>
#import "LFLUIImageView.h"

@interface LFLViewController ()

/// ExampleImageView adapter dark mode
@property (weak, nonatomic) IBOutlet UIImageView *exampleImageView;
/// 采取组件方式适配ImageView
@property (strong, nonatomic) LFLUIImageView *adapterImageView;
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

/// 常见UI标准组件DEMO
- (void)configTestViews {

// 1. UIImageView xib/stroy 适配
//   self.exampleImageView 参考Images.xcassets方式采取系统自动适配
// 1.1 UIImageView 纯代码 项目采取后官方建议xcassets适配，使用组件新的API即可
    [self.view addSubview:self.adapterImageView];
    self.adapterImageView.image = [UIImage imageAdapterNamed:@"exampleImage"];
    UIColor *dyColor = [UIColor colorAdpterWithHex:@"DEMO"];
    
   //2.自定义视图存在圆角的情况下，CALayer层动态颜色处理
    self.customView.backgroundColor = [UIColor grayColor];
    self.customView.layer.cornerRadius = 50.0f;
    self.customView.layer.borderWidth = 10.0f;
    self.customView.layerBorderColorHex = @"DEMO";
    
    //3. UILabel 文本颜色修改 直接使用dyColor 即可。
    self.exampleLabel.textColor = dyColor;
    
    //3. UIButton 直接使用dyColor 即可。
    self.exampleButton.backgroundColor = dyColor;
    //  [self.exampleButton setTitleColor:dyColor forState:UIControlStateSelected|UIControlStateHighlighted];
}



#pragma mark --------
- (LFLUIImageView *)adapterImageView {
    if (!_adapterImageView) {
        _adapterImageView = [[LFLUIImageView alloc]init];
        _adapterImageView.frame = CGRectMake(250, 55, 100, 100);
    }
    return _adapterImageView;
}




@end
