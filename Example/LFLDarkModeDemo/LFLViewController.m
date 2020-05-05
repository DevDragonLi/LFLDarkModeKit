//
//  LFLViewController.m
//  LFLDarkModeKit
//
//  Created by DevDragonli on 05/04/2020.
//  Copyright (c) 2020 DevDragonli. All rights reserved.
//

#import "LFLViewController.h"
#import <LFLDarkModeKit.h>
#import "LFLCustomView.h"

@interface LFLViewController ()

/// ExampleImageView adapter dark mode
@property (weak, nonatomic) IBOutlet UIImageView *exampleImageView;
/// CALayer adapter dark mode
@property (strong,nonatomic) LFLCustomView *customView;

@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;

@end

@implementation LFLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configTestViews];
}

- (void)configTestViews {
    LFLCustomView *customView = [[LFLCustomView alloc]initWithFrame:CGRectMake(100,188, 100, 100)];
    self.customView = customView;
    self.customView.layerBorderColorHex = @"DEMO";
    [self.view addSubview:self.customView];
    self.exampleLabel.textColor = [UIColor ColorAdpterWithHex:@"DEMO"];
}


@end
