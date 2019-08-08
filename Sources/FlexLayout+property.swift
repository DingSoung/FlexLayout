//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import CoreGraphics
import Extension

// MARK: - basic properties
extension FlexLayout {
    public final var direction: CSS.Direction {
        set { YGNodeStyleSetDirection(node, newValue) }
        get { return YGNodeStyleGetDirection(node)}
    }
    public final var flexDirection: CSS.FlexDirection {
        set { YGNodeStyleSetFlexDirection(node, newValue) }
        get { return YGNodeStyleGetFlexDirection(node) }
    }
    public final var justifyContent: CSS.Justify {
        set { YGNodeStyleSetJustifyContent(node, newValue) }
        get { return YGNodeStyleGetJustifyContent(node) }
    }
    public final var alignContent: CSS.Align {
        set { YGNodeStyleSetAlignContent(node, newValue) }
        get { return YGNodeStyleGetAlignContent(node) }
    }
    public final var alignItems: CSS.Align {
        set { YGNodeStyleSetAlignItems(node, newValue) }
        get { return YGNodeStyleGetAlignItems(node) }
    }
    public final var alignSelf: CSS.Align {
        set { YGNodeStyleSetAlignSelf(node, newValue) }
        get { return YGNodeStyleGetAlignSelf(node) }
    }
    public final var position: CSS.Position {
        set { YGNodeStyleSetPositionType(node, newValue) }
        get { return YGNodeStyleGetPositionType(node) }
    }
    public final var flexWrap: CSS.Wrap {
        set { YGNodeStyleSetFlexWrap(node, newValue) }
        get { return YGNodeStyleGetFlexWrap(node) }
    }
    public final var overflow: CSS.Overflow {
        set { YGNodeStyleSetOverflow(node, newValue) }
        get { return YGNodeStyleGetOverflow(node) }
    }
    public final var display: CSS.Display {
        set { YGNodeStyleSetDisplay(node, newValue) }
        get { return YGNodeStyleGetDisplay(node) }
    }
}

// MARK: - Flex Properties
extension FlexLayout {
    public final var flex: CGFloat {
        set { YGNodeStyleSetFlex(node, newValue.float) }
        get { return YGNodeStyleGetFlex(node).cgFloat }
    }
    public final var flexGrow: CGFloat {
        set { YGNodeStyleSetFlexGrow(node, newValue.float) }
        get { return YGNodeStyleGetFlexGrow(node).cgFloat }
    }
    public final var flexShrink: CGFloat {
         set { YGNodeStyleSetFlexShrink(node, newValue.float) }
        get { return YGNodeStyleGetFlexShrink(node).cgFloat }
    }
    public final var flexBasis: CSS.Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetFlexBasis(node, newValue.value)
            case .percent:
                YGNodeStyleSetFlexBasisPercent(node, newValue.value)
            case .auto:
                YGNodeStyleSetFlexBasisAuto(node)
            case .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetFlexBasis(node) }
    }
}

extension FlexLayout {
    public final var resolvedDirection: CSS.Direction {
        return YGNodeLayoutGetDirection(node)
    }
}
