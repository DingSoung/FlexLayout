![Release](https://img.shields.io/github/release/DingSoung/FlexLayout.svg)
![Status](https://travis-ci.org/DingSoung/FlexLayout.svg?branch=master)

![SwiftPackage](https://img.shields.io/badge/SwiftPackage-compatible-E66848.svg?style=flat)

![Language](https://img.shields.io/badge/Swift-5-FFAC45.svg?style=flat)

[![Donate](https://img.shields.io/badge/Donate-PayPal-9EA59D.svg)](https://paypal.me/DingSongwen)

A CSS Flex Layout for iOS

# Install

carthage

```swift
github DingSoung/Extension.git master
```

# Usage

```swift
let layout = FlexLayout()
layout.marginLeft = "10"
layout.width = 300
layout.height = 300
layout.marginTop = 100
layout.alignItems = .flexStart
layout.flexDirection = .row
layout.borderWidth = "3"

let layout2 = FlexLayout()
layout2.aspectRatio = 1
layout2.width = 20%
layout2.margin = 8

layout.set(children: [layout2])
_ = layout.intrinsicSize
print(layout.frame, layout.frame)
```

