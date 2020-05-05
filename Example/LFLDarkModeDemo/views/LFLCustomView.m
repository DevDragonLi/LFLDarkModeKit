//
//  LFLCustomView.m
//  LFLDarkModeDemo
//
//  Created by LFL on 2020/5/4.
//  Copyright © 2020 DevDragonli. All rights reserved.
//

#import "LFLCustomView.h"

@implementation LFLCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // test view config ：cornerRadius ，borderWidth ...
        self.layer.cornerRadius = 50.0f;
        self.layer.borderWidth = 8.0f;
    }
    return self;
}





@end
