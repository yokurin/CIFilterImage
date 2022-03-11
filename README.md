# CIFilterImage

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=for-the-badge)](https://developer.apple.com/iphone/index.action)
[![Cocoapods](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg?style=for-the-badge)](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=for-the-badge)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=for-the-badge)](http://mit-license.org)

## Overview
CIFilterImage provides UI that can be easily filter images.  
This is wrapper of CIFilter.

## Demo
Here are some style of demos using `CIFilterImage`.

| White Theme | Black Theme |
|:---:|:---:|
| <img src="https://github.com/yokurin/CIFilterImage/blob/master/READMEResorces/white.gif"> | <img src="https://github.com/yokurin/CIFilterImage/blob/master/READMEResorces/black.gif"> |

// model: [Pintarest](https://www.pinterest.jp/pin/468304061251876816/)

## Example
Open `CIFilterImage.xcodeproj` and run `CIFilterImage-Example`.

## Usages
```swift
// Create CIFilterViewController
let vc = CIFilterViewController()
vc.image = UIImage(named: "sample")

// customize color
vc.backgroundColor = .white
vc.textColor = .black

// set delegate
vc.delegate = self

```

```swift
extension ViewController: CIFilterViewControllerDelegate {
    // Called when Done Button Tapped
    func didFinish(_ image: UIImage) {
        print("image", image)
    }
    
    // Called when Cancel Button Tapped
    func didCancel() {
        print("did Cancel")
    }
}


```

## Requirements

- iOS 11.4+ (12+ for SPM)
- Xcode 10.2+
- Swift 5.0+

## Installation
### CocoaPods

CIFilterImage is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CIFilterImage'
```

### Carthage

You can integrate via [Carthage](https://github.com/carthage/carthage), too.
Add the following line to your `Cartfile` :

```
github "yokurin/CIFilterImage"
```

and run `carthage update`

### SPM

Just add the repo URL in Xcode

## Author

Tsubasa Hayashi
- Email: yoku.rin.99@gmail.com
- [Github](https://github.com/yokurin)
- [Twitter](https://twitter.com/_yokurin)

## License

CIFilterImage is available under the MIT license. See the LICENSE file for more info.
