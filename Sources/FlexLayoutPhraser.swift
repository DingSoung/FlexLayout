//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics
import Extension

// MARK: - dynamic setValue support
extension CSS.Direction {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.FlexDirection {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Justify {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Align {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Position {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Wrap {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Overflow {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}

extension CSS.Display {
    var nsValue: NSNumber {
        return NSNumber(value: rawValue)
    }
}


class FlexLayoutPhraser {
    @inline(__always)
    private static let cssAlignPhraser: (String) -> CSS.Align = { CSS.Align(stringLiteral: $0) }
    @inline(__always)
    private static let floatPhraser: (String) -> CSS.Float = { CSS.Float(stringLiteral: $0) }
    @inline(__always)
    private static let cssValuePhraser: (String) -> CSS.Value = { CSS.Value(stringLiteral: $0) }

    static func phrase(layout: FlexLayout, map: [String: String]) {
        map.forEach { (pair) in
            switch pair.key {
            case "direction": layout.direction = CSS.Direction(stringLiteral: pair.value)
            case "flex-direction": layout.flexDirection = CSS.FlexDirection(stringLiteral: pair.value)
            case "justify-content": layout.justifyContent = CSS.Justify(stringLiteral: pair.value)
            case "align-content": layout.alignContent = cssAlignPhraser(pair.value)
            case "align-items": layout.alignItems = cssAlignPhraser(pair.value)
            case "align-self": layout.alignSelf = cssAlignPhraser(pair.value)
            case "position": layout.position = CSS.Position(stringLiteral: pair.value)
            case "flex-wrap": layout.flexWrap = CSS.Wrap(stringLiteral: pair.value)
            case "overflow": layout.overflow = CSS.Overflow(stringLiteral: pair.value)
            case "display": layout.display = CSS.Display(stringLiteral: pair.value)
            case "flex": layout.flex = floatPhraser(pair.value).value
            case "flex-grow": layout.flexGrow = floatPhraser(pair.value).value
            case "flex-shrink": layout.flexShrink = floatPhraser(pair.value).value
            
            case "flex-basis": layout.flexBasis = cssValuePhraser(pair.value)
            //position
            case "left": layout.left = cssValuePhraser(pair.value)
            case "top": layout.top = cssValuePhraser(pair.value)
            case "right": layout.right = cssValuePhraser(pair.value)
            case "bottom": layout.bottom = cssValuePhraser(pair.value)
            case "start": layout.start = cssValuePhraser(pair.value)
            case "end": layout.end = cssValuePhraser(pair.value)
            //margin
            case "margin-left": layout.marginLeft = cssValuePhraser(pair.value)
            case "margin-top": layout.marginTop = cssValuePhraser(pair.value)
            case "margin-right": layout.marginRight = cssValuePhraser(pair.value)
            case "margin-bottom": layout.marginBottom = cssValuePhraser(pair.value)
            case "margin-start": layout.marginStart = cssValuePhraser(pair.value)
            case "margin-end": layout.marginEnd = cssValuePhraser(pair.value)
            case "margin-horizontal": layout.marginHorizontal = cssValuePhraser(pair.value)
            case "margin-vertical": layout.marginVertical = cssValuePhraser(pair.value)
            case "margin": layout.margin = cssValuePhraser(pair.value)
            //padding
            case "padding-left": layout.paddingLeft = cssValuePhraser(pair.value)
            case "padding-top": layout.paddingTop = cssValuePhraser(pair.value)
            case "padding-right": layout.paddingRight = cssValuePhraser(pair.value)
            case "padding-bottom": layout.paddingBottom = cssValuePhraser(pair.value)
            case "padding-start": layout.paddingStart = cssValuePhraser(pair.value)
            case "padding-end": layout.paddingEnd = cssValuePhraser(pair.value)
            case "padding-horizontal": layout.paddingHorizontal = cssValuePhraser(pair.value)
            case "padding-vertical": layout.paddingVertical = cssValuePhraser(pair.value)
            case "padding": layout.padding = cssValuePhraser(pair.value)
            // border
            case "border-left-width": layout.borderLeftWidth = floatPhraser(pair.value).value
            case "border-top-width": layout.borderTopWidth = floatPhraser(pair.value).value
            case "border-right-width": layout.borderRightWidth = floatPhraser(pair.value).value
            case "border-bottom-width": layout.borderBottomWidth = floatPhraser(pair.value).value
            case "border-start-width": layout.borderStartWidth = floatPhraser(pair.value).value
            case "border-end-width": layout.borderEndWidth = floatPhraser(pair.value).value
            case "border-width": layout.borderWidth = floatPhraser(pair.value).value
            // width height
            case "width": layout.width = cssValuePhraser(pair.value)
            case "height": layout.height = cssValuePhraser(pair.value)
            case "min-width": layout.minWidth = cssValuePhraser(pair.value)
            case "min-height": layout.minHeight = cssValuePhraser(pair.value)
            case "max-width": layout.maxWidth = cssValuePhraser(pair.value)
            case "max-height": layout.maxHeight = cssValuePhraser(pair.value)
            case "aspect-ratio": layout.aspectRatio = floatPhraser(pair.value).value
            default:
                error("unkonw flex layout key", pair.key)
            }
        }
    }
}
