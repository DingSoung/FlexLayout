//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation

extension CSS {
    public typealias Direction = YGDirection
    public typealias FlexDirection = YGFlexDirection
    public typealias Justify = YGJustify
    public typealias Align = YGAlign
    public typealias Position = YGPositionType
    public typealias Wrap = YGWrap
    public typealias Overflow = YGOverflow
    public typealias Display = YGDisplay
}

// MARK: - = support
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

// MARK: - dynamic setValue support
extension CSS.Direction {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.FlexDirection {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Justify {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Align {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Position {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Wrap {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Overflow {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}

extension CSS.Display {
    var nsValue: NSNumber {
        return NSNumber(value: self.rawValue)
    }
}
