//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import Extension

extension FlexLayout {
    func phrase(layout: [String: String]) {
        layout.forEach {
            switch $0.key {
            case "direction":       direction        = Direction(stringLiteral: $0.value)
            case "flex-direction":  flexDirection    = FlexDirection(stringLiteral: $0.value)
            case "justify-content": justifyContent   = Justify(stringLiteral: $0.value)
            case "align-content":   alignContent     = Align(stringLiteral: $0.value)
            case "align-items":     alignItems       = Align(stringLiteral: $0.value)
            case "align-self":      alignSelf        = Align(stringLiteral: $0.value)
            case "position":        position         = Position(stringLiteral: $0.value)
            case "flex-wrap":       flexWrap         = Wrap(stringLiteral: $0.value)
            case "overflow":        overflow         = Overflow(stringLiteral: $0.value)
            case "display":         display          = Display(stringLiteral: $0.value)
            case "flex":            flex             = Float(stringLiteral: $0.value).value
            case "flex-grow":       flexGrow         = Float(stringLiteral: $0.value).value
            case "flex-shrink":     flexShrink       = Float(stringLiteral: $0.value).value
            case "flex-basis":      flexBasis        = Value(stringLiteral: $0.value)
            //position
            case "left":            left         = Value(stringLiteral: $0.value)
            case "top":             top          = Value(stringLiteral: $0.value)
            case "right":           right        = Value(stringLiteral: $0.value)
            case "bottom":          bottom       = Value(stringLiteral: $0.value)
            case "start":           start        = Value(stringLiteral: $0.value)
            case "end":             end          = Value(stringLiteral: $0.value)
            //margin
            case "margin-left":         marginLeft           = Value(stringLiteral: $0.value)
            case "margin-top":          marginTop            = Value(stringLiteral: $0.value)
            case "margin-right":        marginRight          = Value(stringLiteral: $0.value)
            case "margin-bottom":       marginBottom         = Value(stringLiteral: $0.value)
            case "margin-start":        marginStart          = Value(stringLiteral: $0.value)
            case "margin-end":          marginEnd            = Value(stringLiteral: $0.value)
            case "margin-horizontal":   marginHorizontal     = Value(stringLiteral: $0.value)
            case "margin-vertical":     marginVertical       = Value(stringLiteral: $0.value)
            case "margin":              margin               = Value(stringLiteral: $0.value)
            //padding
            case "padding-left":    paddingLeft              = Value(stringLiteral: $0.value)
            case "padding-top":     paddingTop               = Value(stringLiteral: $0.value)
            case "padding-right":   paddingRight             = Value(stringLiteral: $0.value)
            case "padding-bottom":  paddingBottom            = Value(stringLiteral: $0.value)
            case "padding-start":   paddingStart             = Value(stringLiteral: $0.value)
            case "padding-end":     paddingEnd               = Value(stringLiteral: $0.value)
            case "padding-horizontal":  paddingHorizontal    = Value(stringLiteral: $0.value)
            case "padding-vertical":    paddingVertical      = Value(stringLiteral: $0.value)
            case "padding":             padding              = Value(stringLiteral: $0.value)
            // border
            case "border-left-width":   borderLeftWidth      = Float(stringLiteral: $0.value).value
            case "border-top-width":    borderTopWidth       = Float(stringLiteral: $0.value).value
            case "border-right-width":  borderRightWidth     = Float(stringLiteral: $0.value).value
            case "border-bottom-width": borderBottomWidth    = Float(stringLiteral: $0.value).value
            case "border-start-width":  borderStartWidth     = Float(stringLiteral: $0.value).value
            case "border-end-width":    borderEndWidth       = Float(stringLiteral: $0.value).value
            case "border-width":        borderWidth          = Float(stringLiteral: $0.value).value
            // width height
            case "width":           width        = Value(stringLiteral: $0.value)
            case "height":          height       = Value(stringLiteral: $0.value)
            case "min-width":       minWidth     = Value(stringLiteral: $0.value)
            case "min-height":      minHeight    = Value(stringLiteral: $0.value)
            case "max-width":       maxWidth     = Value(stringLiteral: $0.value)
            case "max-height":      maxHeight    = Value(stringLiteral: $0.value)
            case "aspect-ratio":    aspectRatio  = Float(stringLiteral: $0.value).value
            default:
                error("unkonw flex layout key", $0.key)
            }
        }
    }
}
