//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics
import Extension

class FlexLayoutPhraser {
    @inline(__always)
    private static let cssAlignPhraser: (String) -> CSS.Align = { CSS.Align(stringLiteral: $0) }
    @inline(__always)
    private static let floatPhraser: (String) -> CSS.Float = { CSS.Float(stringLiteral: $0) }
    @inline(__always)
    private static let cssValuePhraser: (String) -> CSS.Value = { CSS.Value(stringLiteral: $0) }

    static func phrase(layout: FlexLayout, map: [String: String]) {
        map.forEach {
            switch $0.key {
            case "direction":       layout.direction        = CSS.Direction(stringLiteral: $0.value)
            case "flex-direction":  layout.flexDirection    = CSS.FlexDirection(stringLiteral: $0.value)
            case "justify-content": layout.justifyContent   = CSS.Justify(stringLiteral: $0.value)
            case "align-content":   layout.alignContent     = cssAlignPhraser($0.value)
            case "align-items":     layout.alignItems       = cssAlignPhraser($0.value)
            case "align-self":      layout.alignSelf        = cssAlignPhraser($0.value)
            case "position":        layout.position         = CSS.Position(stringLiteral: $0.value)
            case "flex-wrap":       layout.flexWrap         = CSS.Wrap(stringLiteral: $0.value)
            case "overflow":        layout.overflow         = CSS.Overflow(stringLiteral: $0.value)
            case "display":         layout.display          = CSS.Display(stringLiteral: $0.value)
            case "flex":            layout.flex             = floatPhraser($0.value).value
            case "flex-grow":       layout.flexGrow         = floatPhraser($0.value).value
            case "flex-shrink":     layout.flexShrink       = floatPhraser($0.value).value
            case "flex-basis":      layout.flexBasis        = cssValuePhraser($0.value)
            //position
            case "left":            layout.left         = cssValuePhraser($0.value)
            case "top":             layout.top          = cssValuePhraser($0.value)
            case "right":           layout.right        = cssValuePhraser($0.value)
            case "bottom":          layout.bottom       = cssValuePhraser($0.value)
            case "start":           layout.start        = cssValuePhraser($0.value)
            case "end":             layout.end          = cssValuePhraser($0.value)
            //margin
            case "margin-left":         layout.marginLeft           = cssValuePhraser($0.value)
            case "margin-top":          layout.marginTop            = cssValuePhraser($0.value)
            case "margin-right":        layout.marginRight          = cssValuePhraser($0.value)
            case "margin-bottom":       layout.marginBottom         = cssValuePhraser($0.value)
            case "margin-start":        layout.marginStart          = cssValuePhraser($0.value)
            case "margin-end":          layout.marginEnd            = cssValuePhraser($0.value)
            case "margin-horizontal":   layout.marginHorizontal     = cssValuePhraser($0.value)
            case "margin-vertical":     layout.marginVertical       = cssValuePhraser($0.value)
            case "margin":              layout.margin               = cssValuePhraser($0.value)
            //padding
            case "padding-left":    layout.paddingLeft              = cssValuePhraser($0.value)
            case "padding-top":     layout.paddingTop               = cssValuePhraser($0.value)
            case "padding-right":   layout.paddingRight             = cssValuePhraser($0.value)
            case "padding-bottom":  layout.paddingBottom            = cssValuePhraser($0.value)
            case "padding-start":   layout.paddingStart             = cssValuePhraser($0.value)
            case "padding-end":     layout.paddingEnd               = cssValuePhraser($0.value)
            case "padding-horizontal":  layout.paddingHorizontal    = cssValuePhraser($0.value)
            case "padding-vertical":    layout.paddingVertical      = cssValuePhraser($0.value)
            case "padding":             layout.padding              = cssValuePhraser($0.value)
            // border
            case "border-left-width":   layout.borderLeftWidth      = floatPhraser($0.value).value
            case "border-top-width":    layout.borderTopWidth       = floatPhraser($0.value).value
            case "border-right-width":  layout.borderRightWidth     = floatPhraser($0.value).value
            case "border-bottom-width": layout.borderBottomWidth    = floatPhraser($0.value).value
            case "border-start-width":  layout.borderStartWidth     = floatPhraser($0.value).value
            case "border-end-width":    layout.borderEndWidth       = floatPhraser($0.value).value
            case "border-width":        layout.borderWidth          = floatPhraser($0.value).value
            // width height
            case "width":           layout.width        = cssValuePhraser($0.value)
            case "height":          layout.height       = cssValuePhraser($0.value)
            case "min-width":       layout.minWidth     = cssValuePhraser($0.value)
            case "min-height":      layout.minHeight    = cssValuePhraser($0.value)
            case "max-width":       layout.maxWidth     = cssValuePhraser($0.value)
            case "max-height":      layout.maxHeight    = cssValuePhraser($0.value)
            case "aspect-ratio":    layout.aspectRatio  = floatPhraser($0.value).value
            default:
                error("unkonw flex layout key", $0.key)
            }
        }
    }
}
