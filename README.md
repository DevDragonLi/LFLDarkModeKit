# LFLDarkModeKit

> Adapter iOS13+ DarkMode 

- **[LFLDarkModeKit Detail](#use)** 

- **[Project Adapter By Apple API Description](#darkMode)** 

## Example

To run the example project, clone the repo, and run `pod install` from the 
Example directory first.

## Installation

LFLDarkModeKit is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby

  pod 'LFLDarkModeKit', '~> 1.0.0

```

## <a name="use"></a> LFLDarkModeKit Detail

- Layout Class   

```
.
├── Core
│   ├── LFLDarkModeManger.h
│   ├── LFLDarkModeManger.m
│   ├── UIColor+LFLDarkMode.h
│   ├── UIColor+LFLDarkMode.m
│   ├── UIView+LFLDarkMode.h
│   └── UIView+LFLDarkMode.m
├── LFLDarkModeKit.h
└── Tool
    ├── NSString+Blank.h
    └── NSString+Blank.m
```

> now only support Hex Color 

- Project create bundle source  
	- **完全各项目自定义色值字符串映射对应颜色**
		- Example：@“DEMO” 在dark和light分别对应不同的真实色值一一映射，后续可支持新增模式
	- Example：darkModeAdapterColor.bundle （Color Set ）
		- dark.plist 
		- light.plist

- didFinishLaunchingWithOptions: configDarkModeColorBundleName 

```
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LFLDarkModeManger sharedInstance] configDarkModeColorBundleName:@"darkModeAdapterColor"];
	    return YES;
	}

```

- Example  

``` 
// view
self.exampleLabel.textColor = [UIColor ColorAdpterWithHex:@"DEMO"];
  
// Imageview 
self.adapterImageView.image = [UIImage imageAdapterNamed:@"exampleImage"];

// Layer 
self.customView.layerBorderColorHex = @"DEMO";
	    
```

## <a name="darkMode"></a> Project Adapter By Apple API Description

### 全局关闭暗黑模式

- 在Info.plist文件中，添加UIUserInterfaceStyle key 名字为 User Interface Style 值为String，将UIUserInterfaceStyle key 的值设置为Light

### images adapter

- 如果项目中有需要适配暗黑模式的图片，可以在Assets.xcassets中设置，具体需要什么样式自己根据项目情况设置
	- any dark 
	
### UIColor

- iOS13 API (当系统切换模式的时候，自动触发这两个方法来动态修改控件颜色)

```

+ (UIColor *)colorWithDynamicProvider:(UIColor * (^)(UITraitCollection *traitCollection))dynamicProvider API_AVAILABLE(ios(13.0), tvos(13.0)) API_UNAVAILABLE(watchOS);

- (UIColor *)initWithDynamicProvider:(UIColor * (^)(UITraitCollection *traitCollection))dynamicProvider API_AVAILABLE(ios(13.0), tvos(13.0)) API_UNAVAILABLE(watchos);

```

### CGColor 

> 设置的CGColor并不会动态改变,可以通过以下方案处理

> 如果适配CGColor，**一般需要各自自定义view实现此函数再处理，较为麻烦**。

- -(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection

```
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
[super traitCollectionDidChange:previousTraitCollection];
    
if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
// Config  Color Adapter 
	}
}

```
- performAsCurrent
	
```
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
[super traitCollectionDidChange:previousTraitCollection];
 [self.traitCollection performAsCurrentTraitCollection:^{
    layer.backgroundColor = xxColor.CGColor;
}];
}
	
```

### VC Config Single Style 
 
```
if (@available(iOS 13.0, *)) {
    
    [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleDark];
    
} else {
    
}
```
### xib / Story 
- color set 
	- any dark 
	- [UIColor colorNamed:@"customBlueColor"] 

### NSAttributedString

```
 NSDictionary * attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor xxColor]};
	
```

### UIActivityIndicatorView


```
typedef NS_ENUM(NSInteger, UIActivityIndicatorViewStyle) {
	
    UIActivityIndicatorViewStyleMedium,
	
    UIActivityIndicatorViewStyleLarge,
	
    UIActivityIndicatorViewStyleWhiteLarge API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleLarge",
	
    UIActivityIndicatorViewStyleWhite API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleMedium",
	
    UIActivityIndicatorViewStyleGray API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleMedium",
	
};
	
```

### Life Style 


- UIView

	- traitCollectionDidChange(_:)
	- layoutSubviews()
	- draw(_:)
	- updateConstraints()
	- tintColorDidChange()

- UIViewController
	- traitCollectionDidChange(_:)
	- updateViewConstraints()
	- viewWillLayoutSubviews()
	- viewDidLayoutSubviews()

- UIPresentationController
	- traitCollectionDidChange(_:)
	- containerViewWillLayoutSubviews()
	- containerViewDidLayoutSubviews()

## Author

> Dragonli_52171@163.com

## License

LFLDarkModeKit is available under the MIT license. See the LICENSE file for more info.

