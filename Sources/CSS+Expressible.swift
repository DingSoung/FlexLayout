//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation

extension CSS.Direction: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        switch value {
        case "ltr": self = .LTR
        case "rtl": self = .RTL
        case "inherit": self = .inherit
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.FlexDirection: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "row": self = .row
        case "row-reverse": self = .rowReverse
        case "column": self = .column
        case "column-reverse": self = .columnReverse
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Justify: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "flex-start": self = .flexStart
        case "center": self = .center
        case "flex-end": self = .flexEnd
        case "space-between": self = .spaceBetween
        case "space-around": self = .spaceAround
        case "space-evenly": self = .spaceEvenly
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Align: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "auto": self = .auto
        case "flex-start": self = .flexStart
        case "center": self = .center
        case "flex-end": self = .flexEnd
        case "stretch": self = .stretch
        case "baseline": self = .baseline
        case "space-between": self = .spaceBetween
        case "space-around": self = .spaceAround
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Position: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "relative": self = .relative
        case "absolute": self = .absolute
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Wrap: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "nowrap": self = .noWrap
        case "wrap": self = .wrap
        case "wrap-reverse": self = .wrapReverse
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Overflow: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "visible": self = .visible
        case "hidden": self = .hidden
        case "scroll": self = .scroll
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension CSS.Display: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "flex": self = .flex
        case "none": self = .none
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

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

extension CSS.Float: ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    init(stringLiteral value: String) {
        if let float = Swift.Float(value) {
            self = CSS.Float(value: float)
            return
        }
        preconditionFailure("This value: \(value) is not invalid")
    }
}