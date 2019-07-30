//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics

public struct CSS {
}

extension CSS {
    private static let cssAlignPhraser: (String) -> NSValue? = { CSS.Align(stringLiteral: $0).nsValue }
    private static let floatPhraser: (String) -> Float? = { Float($0) }
    private static let cssValuePhraser: (String) -> NSValue? = { CSS.Value(stringLiteral: $0).nsValue }

    static var keyParaserMap: [String: (key: String, phrase: (String) -> Any?)] = [
        "direction": ("direction", { CSS.Direction(stringLiteral: $0).nsValue }),
        "flex-direction": ("flexDirection", { CSS.FlexDirection(stringLiteral: $0).nsValue }),
        "justify-content": ("justifyContent", { CSS.Justify(stringLiteral: $0).nsValue }),
        "align-content": ("alignContent", cssAlignPhraser),
        "align-items": ("alignItems", cssAlignPhraser),
        "align-self": ("alignSelf", cssAlignPhraser),
        "position": ("position", { CSS.Position(stringLiteral: $0).nsValue }),
        "flex-wrap": ("flexWrap", { CSS.Wrap(stringLiteral: $0).nsValue }),
        "overflow": ("overflow", { CSS.Overflow(stringLiteral: $0).nsValue }),
        "display": ("display", { CSS.Display(stringLiteral: $0).nsValue }),

        "flex": ("flex", floatPhraser),
        "flex-grow": ("flexGrow", floatPhraser),
        "flex-shrink": ("flexShrink", floatPhraser),
        "flex-basis": ("flexBasis", cssValuePhraser),

        "left": ("left", cssValuePhraser),
        "top": ("top", cssValuePhraser),
        "right": ("right", cssValuePhraser),
        "bottom": ("bottom", cssValuePhraser),
        "start": ("start", cssValuePhraser),
        "end": ("end", cssValuePhraser),
        "margin-left": ("marginLeft", cssValuePhraser),
        "margin-top": ("marginTop", cssValuePhraser),
        "margin-right": ("marginRight", cssValuePhraser),
        "margin-bottom": ("marginBottom", cssValuePhraser),
        "margin-start": ("marginStart", cssValuePhraser),
        "margin-end": ("marginEnd", cssValuePhraser),
        "margin-horizontal": ("marginHorizontal", cssValuePhraser),
        "margin-vertica": ("marginVertica", cssValuePhraser),
        "margin": ("margin", cssValuePhraser),
        "padding-left": ("paddingLeft", cssValuePhraser),
        "padding-top": ("paddingTop", cssValuePhraser),
        "padding-right": ("paddingRight", cssValuePhraser),
        "padding-bottom": ("paddingBottom", cssValuePhraser),
        "padding-start": ("paddingStart", cssValuePhraser),
        "padding-end": ("paddingEnd", cssValuePhraser),
        "padding-horizontal": ("paddingHorizontal", cssValuePhraser),
        "padding-vertical": ("paddingVertical", cssValuePhraser),
        "padding": ("padding", cssValuePhraser),

        "border-left-width": ("borderLeftWidth", floatPhraser),
        "border-top-width": ("borderTopWidth", floatPhraser),
        "border-right-width": ("borderRightWidth", floatPhraser),
        "border-bottom-width": ("borderBottomWidth", floatPhraser),
        "border-start-width": ("borderStartWidth", floatPhraser),
        "border-end-width": ("borderEndWidth", floatPhraser),
        "border-width": ("borderWidth", floatPhraser),

        "width": ("width", cssValuePhraser),
        "height": ("height", cssValuePhraser),
        "min-width": ("minWidth", cssValuePhraser),
        "min-height": ("minHeight", cssValuePhraser),
        "max-width": ("maxWidth", cssValuePhraser),
        "max-height": ("maxHeight", cssValuePhraser),
        
        "aspect-ratio": ("aspectRatio", floatPhraser)
    ]
}
