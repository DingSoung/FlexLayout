//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import Extension

// MARK: - basic properties
extension FlexLayout {
    public final var direction: Direction {
        set { YGNodeStyleSetDirection(node, newValue) }
        get { return YGNodeStyleGetDirection(node)}
    }
    public final var flexDirection: FlexDirection {
        set { YGNodeStyleSetFlexDirection(node, newValue) }
        get { return YGNodeStyleGetFlexDirection(node) }
    }
    public final var justifyContent: Justify {
        set { YGNodeStyleSetJustifyContent(node, newValue) }
        get { return YGNodeStyleGetJustifyContent(node) }
    }
    public final var alignContent: Align {
        set { YGNodeStyleSetAlignContent(node, newValue) }
        get { return YGNodeStyleGetAlignContent(node) }
    }
    public final var alignItems: Align {
        set { YGNodeStyleSetAlignItems(node, newValue) }
        get { return YGNodeStyleGetAlignItems(node) }
    }
    public final var alignSelf: Align {
        set { YGNodeStyleSetAlignSelf(node, newValue) }
        get { return YGNodeStyleGetAlignSelf(node) }
    }
    public final var position: Position {
        set { YGNodeStyleSetPositionType(node, newValue) }
        get { return YGNodeStyleGetPositionType(node) }
    }
    public final var flexWrap: Wrap {
        set { YGNodeStyleSetFlexWrap(node, newValue) }
        get { return YGNodeStyleGetFlexWrap(node) }
    }
    public final var overflow: Overflow {
        set { YGNodeStyleSetOverflow(node, newValue) }
        get { return YGNodeStyleGetOverflow(node) }
    }
    public final var display: Display {
        set { YGNodeStyleSetDisplay(node, newValue) }
        get { return YGNodeStyleGetDisplay(node) }
    }
}

// MARK: - Flex Properties
extension FlexLayout {
    public final var flex: Float {
        set { YGNodeStyleSetFlex(node, newValue) }
        get { return YGNodeStyleGetFlex(node) }
    }
    public final var flexGrow: Float {
        set { YGNodeStyleSetFlexGrow(node, newValue) }
        get { return YGNodeStyleGetFlexGrow(node) }
    }
    public final var flexShrink: Float {
         set { YGNodeStyleSetFlexShrink(node, newValue) }
        get { return YGNodeStyleGetFlexShrink(node) }
    }
    public final var flexBasis: Value {
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
    public final var resolvedDirection: Direction {
        return YGNodeLayoutGetDirection(node)
    }
}
