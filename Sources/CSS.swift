//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics

public struct CSS {
}

extension CSS {
    static var keyParaserMap: [String: (key: String, phrase: (String) -> Any?)] = [
        "direction": ("direction", { CSS.Direction(stringLiteral: $0).nsValue }),
        "flex-direction": ("flexDirection", { CSS.FlexDirection(stringLiteral: $0).nsValue }),
        "justify-content": ("justifyContent", { CSS.Justify(stringLiteral: $0).nsValue }),
        "align-content": ("alignContent", { CSS.Align(stringLiteral: $0).nsValue }),
        "align-items": ("alignItems", { CSS.Align(stringLiteral: $0).nsValue }),
        "align-self": ("alignSelf", { CSS.Align(stringLiteral: $0).nsValue }),
        "position": ("position", { CSS.Position(stringLiteral: $0).nsValue }),
        "flex-wrap": ("flexWrap", { CSS.Wrap(stringLiteral: $0).nsValue }),
        "overflow": ("overflow", { CSS.Overflow(stringLiteral: $0).nsValue }),
        "display": ("display", { CSS.Display(stringLiteral: $0).nsValue }),

        "flex": ("flex", { Float($0) }),
        "flex-grow": ("flexGrow", { Float($0) }),
        "flex-shrink": ("flexShrink", { Float($0) }),
        "flex-basis": ("flexBasis", { CSS.Value(stringLiteral: $0).nsValue }),

        "left": ("left", { CSS.Value(stringLiteral: $0).nsValue }),
        "top": ("top", { CSS.Value(stringLiteral: $0).nsValue }),
        "right": ("right", { CSS.Value(stringLiteral: $0).nsValue }),
        "bottom": ("bottom", { CSS.Value(stringLiteral: $0).nsValue }),
        "start": ("start", { CSS.Value(stringLiteral: $0).nsValue }),
        "end": ("end", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-left": ("marginLeft", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-top": ("marginTop", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-right": ("marginRight", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-bottom": ("marginBottom", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-start": ("marginStart", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-end": ("marginEnd", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-horizontal": ("marginHorizontal", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin-vertica": ("marginVertica", { CSS.Value(stringLiteral: $0).nsValue }),
        "margin": ("margin", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-left": ("paddingLeft", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-top": ("paddingTop", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-right": ("paddingRight", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-bottom": ("paddingBottom", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-start": ("paddingStart", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-end": ("paddingEnd", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-horizontal": ("paddingHorizontal", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding-vertical": ("paddingVertical", { CSS.Value(stringLiteral: $0).nsValue }),
        "padding": ("padding", { CSS.Value(stringLiteral: $0).nsValue }),

        "border-left-width": ("borderLeftWidth", { Float($0) }),
        "border-top-width": ("borderTopWidth", { Float($0) }),
        "border-right-width": ("borderRightWidth", { Float($0) }),
        "border-bottom-width": ("borderBottomWidth", { Float($0) }),
        "border-start-width": ("borderStartWidth", { Float($0) }),
        "border-end-width": ("borderEndWidth", { Float($0) }),
        "border-width": ("borderWidth", { Float($0) }),

        "width": ("width", { CSS.Value(stringLiteral: $0).nsValue }),
        "height": ("height", { CSS.Value(stringLiteral: $0).nsValue }),
        "min-width": ("minWidth", { CSS.Value(stringLiteral: $0).nsValue }),
        "min-height": ("minHeight", { CSS.Value(stringLiteral: $0).nsValue }),
        "max-width": ("maxWidth", { CSS.Value(stringLiteral: $0).nsValue }),
        "max-height": ("maxHeight", { CSS.Value(stringLiteral: $0).nsValue }),

        "aspect-ratio": ("aspectRatio", { Float($0) })
        ]
}
