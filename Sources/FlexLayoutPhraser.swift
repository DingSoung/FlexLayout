//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import Extension

class FlexLayoutPhraser {
    static func phrase(layout: FlexLayout, map: [String: String]) {
        map.forEach {
            switch $0.key {
            case "direction":       layout.direction        = CSS.Direction(stringLiteral: $0.value)
            case "flex-direction":  layout.flexDirection    = CSS.FlexDirection(stringLiteral: $0.value)
            case "justify-content": layout.justifyContent   = CSS.Justify(stringLiteral: $0.value)
            case "align-content":   layout.alignContent     = CSS.Align(stringLiteral: $0.value)
            case "align-items":     layout.alignItems       = CSS.Align(stringLiteral: $0.value)
            case "align-self":      layout.alignSelf        = CSS.Align(stringLiteral: $0.value)
            case "position":        layout.position         = CSS.Position(stringLiteral: $0.value)
            case "flex-wrap":       layout.flexWrap         = CSS.Wrap(stringLiteral: $0.value)
            case "overflow":        layout.overflow         = CSS.Overflow(stringLiteral: $0.value)
            case "display":         layout.display          = CSS.Display(stringLiteral: $0.value)
            case "flex":            layout.flex             = CSS.Float(stringLiteral: $0.value).value
            case "flex-grow":       layout.flexGrow         = CSS.Float(stringLiteral: $0.value).value
            case "flex-shrink":     layout.flexShrink       = CSS.Float(stringLiteral: $0.value).value
            case "flex-basis":      layout.flexBasis        = CSS.Value(stringLiteral: $0.value)
            //position
            case "left":            layout.left         = CSS.Value(stringLiteral: $0.value)
            case "top":             layout.top          = CSS.Value(stringLiteral: $0.value)
            case "right":           layout.right        = CSS.Value(stringLiteral: $0.value)
            case "bottom":          layout.bottom       = CSS.Value(stringLiteral: $0.value)
            case "start":           layout.start        = CSS.Value(stringLiteral: $0.value)
            case "end":             layout.end          = CSS.Value(stringLiteral: $0.value)
            //margin
            case "margin-left":         layout.marginLeft           = CSS.Value(stringLiteral: $0.value)
            case "margin-top":          layout.marginTop            = CSS.Value(stringLiteral: $0.value)
            case "margin-right":        layout.marginRight          = CSS.Value(stringLiteral: $0.value)
            case "margin-bottom":       layout.marginBottom         = CSS.Value(stringLiteral: $0.value)
            case "margin-start":        layout.marginStart          = CSS.Value(stringLiteral: $0.value)
            case "margin-end":          layout.marginEnd            = CSS.Value(stringLiteral: $0.value)
            case "margin-horizontal":   layout.marginHorizontal     = CSS.Value(stringLiteral: $0.value)
            case "margin-vertical":     layout.marginVertical       = CSS.Value(stringLiteral: $0.value)
            case "margin":              layout.margin               = CSS.Value(stringLiteral: $0.value)
            //padding
            case "padding-left":    layout.paddingLeft              = CSS.Value(stringLiteral: $0.value)
            case "padding-top":     layout.paddingTop               = CSS.Value(stringLiteral: $0.value)
            case "padding-right":   layout.paddingRight             = CSS.Value(stringLiteral: $0.value)
            case "padding-bottom":  layout.paddingBottom            = CSS.Value(stringLiteral: $0.value)
            case "padding-start":   layout.paddingStart             = CSS.Value(stringLiteral: $0.value)
            case "padding-end":     layout.paddingEnd               = CSS.Value(stringLiteral: $0.value)
            case "padding-horizontal":  layout.paddingHorizontal    = CSS.Value(stringLiteral: $0.value)
            case "padding-vertical":    layout.paddingVertical      = CSS.Value(stringLiteral: $0.value)
            case "padding":             layout.padding              = CSS.Value(stringLiteral: $0.value)
            // border
            case "border-left-width":   layout.borderLeftWidth      = CSS.Float(stringLiteral: $0.value).value
            case "border-top-width":    layout.borderTopWidth       = CSS.Float(stringLiteral: $0.value).value
            case "border-right-width":  layout.borderRightWidth     = CSS.Float(stringLiteral: $0.value).value
            case "border-bottom-width": layout.borderBottomWidth    = CSS.Float(stringLiteral: $0.value).value
            case "border-start-width":  layout.borderStartWidth     = CSS.Float(stringLiteral: $0.value).value
            case "border-end-width":    layout.borderEndWidth       = CSS.Float(stringLiteral: $0.value).value
            case "border-width":        layout.borderWidth          = CSS.Float(stringLiteral: $0.value).value
            // width height
            case "width":           layout.width        = CSS.Value(stringLiteral: $0.value)
            case "height":          layout.height       = CSS.Value(stringLiteral: $0.value)
            case "min-width":       layout.minWidth     = CSS.Value(stringLiteral: $0.value)
            case "min-height":      layout.minHeight    = CSS.Value(stringLiteral: $0.value)
            case "max-width":       layout.maxWidth     = CSS.Value(stringLiteral: $0.value)
            case "max-height":      layout.maxHeight    = CSS.Value(stringLiteral: $0.value)
            case "aspect-ratio":    layout.aspectRatio  = CSS.Float(stringLiteral: $0.value).value
            default:
                error("unkonw flex layout key", $0.key)
            }
        }
    }
}
