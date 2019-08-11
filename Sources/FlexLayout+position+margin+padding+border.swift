//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import Extension

extension FlexLayout {
    @inline(__always)
    private func setPosition(_ value: CSS.Value, _ edge: YGEdge) {
        switch value.unit {
        case .undefined, .point:
            YGNodeStyleSetPosition(node, edge, value.value)
        case .percent:
            YGNodeStyleSetPositionPercent(node, edge, value.value)
        case .auto:
            error("not implemented")
        @unknown default:
            fatalError()
        }
    }
    @inline(__always)
    private func setMargin(_ value: CSS.Value, _ edge: YGEdge) {
        switch value.unit {
        case .undefined, .point:
            YGNodeStyleSetMargin(node, edge, value.value)
        case .percent:
            YGNodeStyleSetMarginPercent(node, edge, value.value)
        case .auto:
            error("not implemented")
        @unknown default:
            fatalError()
        }
    }
    @inline(__always)
    private func setPadding(_ value: CSS.Value, _ edge: YGEdge) {
        switch value.unit {
        case .undefined, .point:
            YGNodeStyleSetPadding(node, edge, value.value)
        case .percent:
            YGNodeStyleSetPaddingPercent(node, edge, value.value)
        case .auto:
            error("not implemented")
        @unknown default:
            fatalError()
        }
    }
}

// MARK: - position
extension FlexLayout {
    public final var left: CSS.Value {
        set { setPosition(newValue, .left) }
        get { return YGNodeStyleGetPosition(node, .left) }
    }
    public final var top: CSS.Value {
        set { setPosition(newValue, .top) }
        get { return YGNodeStyleGetPosition(node, .top) }
    }
    public final var right: CSS.Value {
        set { setPosition(newValue, .right) }
        get { return YGNodeStyleGetPosition(node, .right) }
    }
    public final var bottom: CSS.Value {
        set { setPosition(newValue, .bottom) }
        get { return YGNodeStyleGetPosition(node, .bottom) }
    }
    public final var start: CSS.Value {
        set { setPosition(newValue, .start) }
        get { return YGNodeStyleGetPosition(node, .start) }
    }
    public final var end: CSS.Value {
        set { setPosition(newValue, .end) }
        get { return YGNodeStyleGetPosition(node, .end) }
    }
}

// MARK: - margin
extension FlexLayout {
    public final var marginLeft: CSS.Value {
        set { setMargin(newValue, .left) }
        get { return YGNodeStyleGetMargin(node, .left) }
    }
    public final var marginTop: CSS.Value {
        set { setMargin(newValue, .top) }
        get { return YGNodeStyleGetMargin(node, .top) }
    }
    public final var marginRight: CSS.Value {
        set { setMargin(newValue, .right) }
        get { return YGNodeStyleGetMargin(node, .right) }
    }
    public final var marginBottom: CSS.Value {
        set { setMargin(newValue, .bottom) }
        get { return YGNodeStyleGetMargin(node, .bottom) }
    }
    public final var marginStart: CSS.Value {
        set { setMargin(newValue, .start) }
        get { return YGNodeStyleGetMargin(node, .start) }
    }
    public final var marginEnd: CSS.Value {
        set { setMargin(newValue, .end) }
        get { return YGNodeStyleGetMargin(node, .end) }
    }
    public final var marginHorizontal: CSS.Value {
        set { setMargin(newValue, .horizontal) }
        get { return YGNodeStyleGetMargin(node, .horizontal) }
    }
    public final var marginVertical: CSS.Value {
        set { setMargin(newValue, .vertical) }
        get { return YGNodeStyleGetMargin(node, .vertical) }
    }
    public final var margin: CSS.Value {
        set { setMargin(newValue, .all) }
        get { return YGNodeStyleGetMargin(node, .all) }
    }
}

// MARK: - padding
extension FlexLayout {
    public final var paddingLeft: CSS.Value {
        set { setPadding(newValue, .left) }
        get { return YGNodeStyleGetPadding(node, .left) }
    }
    public final var paddingTop: CSS.Value {
        set { setPadding(newValue, .top) }
        get { return YGNodeStyleGetPadding(node, .top) }
    }
    public final var paddingRight: CSS.Value {
        set { setPadding(newValue, .right) }
        get { return YGNodeStyleGetPadding(node, .right) }
    }
    public final var paddingBottom: CSS.Value {
        set { setPadding(newValue, .bottom) }
        get { return YGNodeStyleGetPadding(node, .bottom) }
    }
    public final var paddingStart: CSS.Value {
        set { setPadding(newValue, .start) }
        get { return YGNodeStyleGetPadding(node, .start) }
    }
    public final var paddingEnd: CSS.Value {
        set { setPadding(newValue, .end) }
        get { return YGNodeStyleGetPadding(node, .end) }
    }
    public final var paddingHorizontal: CSS.Value {
        set { setPadding(newValue, .horizontal) }
        get { return YGNodeStyleGetPadding(node, .horizontal) }
    }
    public final var paddingVertical: CSS.Value {
        set { setPadding(newValue, .vertical) }
        get { return YGNodeStyleGetPadding(node, .vertical) }
    }
    public final var padding: CSS.Value {
        set { setPadding(newValue, .all) }
        get { return YGNodeStyleGetPadding(node, .all) }
    }
}

// MARK: - border
extension FlexLayout {
    public final var borderLeftWidth: Float {
        set { YGNodeStyleSetBorder(node, .left, newValue) }
        get { return YGNodeStyleGetBorder(node, .left) }
    }
    public final var borderTopWidth: Float {
        set { YGNodeStyleSetBorder(node, .top, newValue) }
        get { return YGNodeStyleGetBorder(node, .top) }
    }
    public final var borderRightWidth: Float {
        set { YGNodeStyleSetBorder(node, .right, newValue) }
        get { return YGNodeStyleGetBorder(node, .right) }
    }
    public final var borderBottomWidth: Float {
        set { YGNodeStyleSetBorder(node, .bottom, newValue) }
        get { return YGNodeStyleGetBorder(node, .bottom) }
    }
    public final var borderStartWidth: Float {
        set { YGNodeStyleSetBorder(node, .start, newValue) }
        get { return YGNodeStyleGetBorder(node, .start) }
    }
    public final var borderEndWidth: Float {
        set { YGNodeStyleSetBorder(node, .end, newValue) }
        get { return YGNodeStyleGetBorder(node, .end) }
    }
    public final var borderWidth: Float {
        set { YGNodeStyleSetBorder(node, .all, newValue) }
        get { return YGNodeStyleGetBorder(node, .all) }
    }
}
