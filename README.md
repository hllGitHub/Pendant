# Pendant

[![CI Status](https://img.shields.io/travis/liangliang.hu/Pendant.svg?style=flat)](https://travis-ci.org/liangliang.hu/Pendant)
[![Version](https://img.shields.io/cocoapods/v/Pendant.svg?style=flat)](https://cocoapods.org/pods/Pendant)
[![License](https://img.shields.io/cocoapods/l/Pendant.svg?style=flat)](https://cocoapods.org/pods/Pendant)
[![Platform](https://img.shields.io/cocoapods/p/Pendant.svg?style=flat)](https://cocoapods.org/pods/Pendant)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Document

### OrientationManager

用来支持屏幕旋转.

``` swift
OrientationManager.shared.rotateOrientationForLandscape(isLandscape: true)
```

#### Requirements

* 对于 push 的 viewController，需要让上层的 UINavigationController 也支持，并且需要覆盖实现 `supportedInterfaceOrientations`，需要转屏的 viewController 也需要实现。
* 如果希望支持自动旋转，那么还需要实现 `shouldAutorotate`
* push 出来的 viewController 需要手动触发转屏方法，并且要在 `viewWillAppear` 或 `viewDidAppear` 中调用，否则无法起到效果
* 对于 present 的 viewController，只要实现了 `supportedInterfaceOrientations` 和 `shouldAutorotate` 就会自动转屏。

参考实现：
``` swift
class PendantNavigationController: UINavigationController {
  
  override var shouldAutorotate: Bool {
    return self.topViewController?.shouldAutorotate ?? false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return self.topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }
  
}
```

``` swift
override var shouldAutorotate: Bool {
  return true
}
  
override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
  return isLandscape ? .landscape : .portrait
}

func rotateScreenIfNeed() {
  // present 和 dismiss 时会触发页面转动。对于 push 和 pop 操作不会被动触发页面转动，需要手动 setOrientation 来触发
  guard self.presentingViewController == nil, DeviceOrientation.isLandscape != isLandscape else {
    return
  }
    
  OrientationManager.shared.rotateOrientationForLandscape(isLandscape: isLandscape)
}
```

### UserDefault

参考实现：

``` swift
struct PendantUserDefaults {
  @UserDefault<Bool>(key: "isFirstLoggedIn", defaultValue: false)
  static var isFirstLoggedIn

  @UserDefault<Bool>(key: "isEnterGame", defaultValue: false, storage: UserDefaults.standard)
  var isEnterGame
}
```

``` swift
@UserDefault<Bool>(key: "mark-as-read", defaultValue: true)
  var autoMarkMessageAsRead

  @UserDefault<Int>(key: "search-page-size", defaultValue: 20)
  var numberOfSearchResultsPerPage
```

### ColorHelper

目前比较简单，只提供了 random 的实现和十六进制字符串初始化方法

``` swift
view.backgroundColor = .random
view.backgroundColor = UIColor(hexString: "0xFFFFFF")
```

### LiteralsHelper

用法也比较简单

``` swift
let url: URL = "https://www.baidu.com"
```

## Requirements

iOS 9.0

## Installation

Pendant is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pendant'
```

## Author

liangliang.hu, hllfj922@gmail.com

## License

Pendant is available under the MIT license. See the LICENSE file for more info.
