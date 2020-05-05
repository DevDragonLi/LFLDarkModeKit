# LFLDarkModeKit

> 适配iOS13 暗黑模式组件

- **[组件使用指南](#use)** 
- **[项目适配暗黑模式相关指南](#darkMode)** 

## Example

To run the example project, clone the repo, and run `pod install` from the 
Example directory first.


## <a name="use"></a> 组件使用指南

> 目前只适配项目使用Hex的色值体系

- 宿主工程目录下新建bundle（可参考此repo demo ）
	- 一个项目自定义色值字符串对应二个颜色（dark和light对应的真实色值）一一对应，后续新增模式可扩展
	-  darkModeAdapterColor.bundle（内部名称为dark.plist和light.plist）
		- dark.plist
		-  light.plist
- **初始化：** didFinishLaunchingWithOptions 初始化传入bundle名称，组件内部会解析

	```
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	    [[LFLDarkModeManger sharedInstance] configDarkModeColorBundleName:@"darkModeAdapterColor"];
	    return YES;
	}
	```
- Example  
	- DEMO 为示例工程自定义色值字符串

	```
	// view类型
	    self.exampleLabel.textColor = [UIColor ColorAdpterWithHex:@"DEMO"];
	    
	// Layer 类型
	    self.customView.layerBorderColorHex = @"DEMO";
	    
	```


## Installation

LFLDarkModeKit is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby

pod 'LFLDarkModeKit'

```

## <a name="darkMode"></a> 适配 iOS 13 暗黑模式

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

- 调用监听模式切换 : -(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection,对应视图处理相关逻辑

	```
	- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	    [super traitCollectionDidChange:previousTraitCollection];
	    // trait发生了改变才会执行刷新操作
	    if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
	    // 执行颜色相关逻辑
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

### 单独模式（VC）

```
	if (@available(iOS 13.0, *)) {
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleDark];
    } else {
    }
```
### xib
- color set 
	- any dark 
	- [UIColor colorNamed:@"customBlueColor"] 

### NSAttributedString

```
NSDictionary * attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor xxColor]};

```

### UIActivityIndicatorView

- 建议使用新的枚举类型

	```
	typedef NS_ENUM(NSInteger, UIActivityIndicatorViewStyle) {

	    UIActivityIndicatorViewStyleMedium,
	
	    UIActivityIndicatorViewStyleLarge,
	
	    UIActivityIndicatorViewStyleWhiteLarge API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleLarge",
	
	    UIActivityIndicatorViewStyleWhite API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleMedium",
	
	    UIActivityIndicatorViewStyleGray API_DEPRECATED_WITH_REPLACEMENT("UIActivityIndicatorViewStyleMedium",
	
	};
	
	```

### 更改外观触发系统会通知所有window与View需要更新样式

```
UIView

traitCollectionDidChange(_:)
layoutSubviews()
draw(_:)
updateConstraints()
tintColorDidChange()

UIViewController

traitCollectionDidChange(_:)
updateViewConstraints()
viewWillLayoutSubviews()
viewDidLayoutSubviews()

UIPresentationController

traitCollectionDidChange(_:)
containerViewWillLayoutSubviews()
containerViewDidLayoutSubviews()

```

## Author

> Dragonli_52171@163.com

## License

LFLDarkModeKit is available under the MIT license. See the LICENSE file for more info.

