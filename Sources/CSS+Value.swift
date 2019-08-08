//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics

extension CSS {
    public typealias Unit = YGUnit
    public typealias Value = YGValue
}

// MARK: = support
extension CSS.Value: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Int) {
        self = CSS.Value(value: Float(value), unit: .point)
    }
}

extension CSS.Value: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    public init(floatLiteral value: Float) {
        self = CSS.Value(value: Float(value), unit: .point)
    }
}

extension CSS.Value: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        var str = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if str == "auto" {
            self = .auto
            return
        } else if str.last == "%" {
            str = String(str.prefix(str.count - 1))
            if let number = Float(str) {
                self = CSS.Value(value: number, unit: .percent)
                return
            }
        } else {
            if let number = Float(str) {
                self = CSS.Value(value: number, unit: .point)
                return
            }
        }
        preconditionFailure("This value: \(value) is not invalid")
    }
}

// MARK: const value
extension CSS.Value {
    public static let auto: CSS.Value = YGValueAuto
    public static let undefined: CSS.Value = YGValueUndefined
    public static let zero: CSS.Value = YGValueZero
}

// MARK: kvo support
extension CSS.Value {
    public var nsValue: NSValue {
        //return NSValue.valuewithYGValue(self)
        return NSValue()
    }
}

// MARK: % percent convert
postfix operator %

extension Int {
    public static postfix func % (value: Int) -> CSS.Value {
        return CSS.Value(value: Float(value), unit: .percent)
    }
}

extension Float {
    public static postfix func % (value: Float) -> CSS.Value {
        return CSS.Value(value: value, unit: .percent)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    public static postfix func % (value: CGFloat) -> CSS.Value {
        return CSS.Value(value: Float(value), unit: .percent)
    }
    var float: Float {
        return Float(self)
    }
}
