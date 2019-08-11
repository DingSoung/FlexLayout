![Release](https://img.shields.io/github/release/DingSoung/FlexLayout.svg)
![Status](https://travis-ci.org/DingSoung/FlexLayout.svg?branch=master)

![SwiftPackage](https://img.shields.io/badge/SwiftPackage-compatible-E66848.svg?style=flat)

![Language](https://img.shields.io/badge/Swift-5-FFAC45.svg?style=flat)

[![Donate](https://img.shields.io/badge/Donate-PayPal-9EA59D.svg)](https://paypal.me/DingSongwen)

一个 iOS 的 Flexbox Layout 工具

# 安装

Swift Package Manager

```swift
https://github.com/DingSoung/FlexLayout master
```

Carthage

```swift
github: DingSoung/FlexLayout master
```

# 使用

## 构造树

```swift
let layout1 = FlexLayout()
layout1....
let layout2 = FlexLayout()
layout1....
let layout3 = FlexLayout()
layout1.set(children: [layout2, layout3])
```

## 计算

```swift
_ = layout1.intrinsicSize
print(layout1.frame, layout2.frame, layout3.frame)
```

## 赋值方式

### 方式 1: 直接赋值

* 数值，美剧，结构

```swift
let layout = FlexLayout()
layout.width = .Value(value: 80, unit: .percent)
layout.height = 300
layout.alignItems = .flexStart
```

* 支持字符串复制

```swift
let layout = FlexLayout()
layout.height = "300"
layout.alignItems = "flex-start"
layout.width = "80%"
```

* 支持百分数

```swift
let layout = FlexLayout()
layout.width = 80%
```

### 方式 2: 动态赋值

* CSS 字典 

```swift
let layout = FlexLayout()
layout.set(layout: [
		"aspect-ratio": "1",
		"width": "50%",
		"margin": "8"
     ]
)
```

* CSS 字符串

```swift
let layout = FlexLayout()
layout.set(layout: "aspect-ratio: 1; width: 50%; margin: 8")
```

### 方式 3: 链式调用

```swift
let layout = FlexLayout()
	.margin(8)
	.flexShrink(1)
	.width(100%)
	.height(.auto)
```