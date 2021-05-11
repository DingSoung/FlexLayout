//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Extension
import Foundation
import YogaKit

#if canImport(UIKit)
import UIKit
private let screenScale = UIScreen.main.scale
#else
private let screenScale: CGFloat = 3.0
#endif

open class FlexLayout {
    private var isEnabled = true
    private var isIncludedInLayout = true

    private class Context {
        var sizeThatFits: (CGSize) -> CGSize
        init(sizeThatFits: @escaping (CGSize) -> CGSize) {
            self.sizeThatFits = sizeThatFits
        }
    }

    private var context: Context?

    // Flex Layout Guide: http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html
    lazy var node: YGNodeRef = {
        let globalConfig: YGConfigRef = YGConfigNew()
        YGConfigSetExperimentalFeatureEnabled(globalConfig, .webFlexBasis, true)
        YGConfigSetPointScaleFactor(globalConfig, Float(screenScale))
        return YGNodeNewWithConfig(globalConfig)
    }()

    private var children = [FlexLayout]()

    public init() {}
}

// MARK: - Structure
extension FlexLayout {
    @discardableResult
    public final func set(children: [FlexLayout]) -> Self {
        self.children = children
        if isLeaf {
        } else {
            YGNodeSetMeasureFunc(node, nil)
            let children = children.filter({ $0.isEnabled && $0.isIncludedInLayout })
            if !FlexLayout.nodeHasExactSameChildren(node: node, children: children) {
                YGNodeRemoveAllChildren(node)
                for index in 0..<children.count {
                    YGNodeInsertChild(node, children[index].node, UInt32(index))
                }
            }
        }
        return self
    }

    @discardableResult
    public final func set(sizeThatFits: @escaping (CGSize) -> CGSize) -> Self {
        if isLeaf {
            context = Context(sizeThatFits: sizeThatFits)
            YGNodeSetContext(node, &context)
            YGNodeSetMeasureFunc(node, FlexLayout.measureFunc)
        } else {
            YGNodeSetMeasureFunc(node, nil)
        }
        return self
    }
}

extension FlexLayout {
    private var isLeaf: Bool {
        if isEnabled
            && children.first(where: { $0.isEnabled && $0.isIncludedInLayout }) != nil {
            return false
        }
        return true
    }
}

extension FlexLayout {
    private static func nodeHasExactSameChildren(node: YGNodeRef, children: [FlexLayout]) -> Bool {
        if YGNodeGetChildCount(node) != children.count {
            return false
        }
        for index in 0..<children.count {
            if YGNodeGetChild(node, UInt32(index)) != children[index].node {
                return false
            }
        }
        return true
    }

    private static let measureFunc:
        @convention(c) (YGNodeRef?, Float, YGMeasureMode, Float, YGMeasureMode) -> YGSize = {
        (node, width, widthMode, height, heightMode) in
        let constrainedWidth = widthMode == .undefined ? Float.greatestFiniteMagnitude : width
        let constrainedHeight = heightMode == .undefined ? Float.greatestFiniteMagnitude: height
        var measureSize = CGSize.zero
        if let context = YGNodeGetContext(node)?.assumingMemoryBound(to: Context.self).pointee {
            measureSize = context.sizeThatFits(CGSize(width: constrainedWidth, height: constrainedHeight))
        } else {
            warning("no measureFunc")
        }
        return YGSize(width: sanitizeMeasurement(constrainedWidth, Float(measureSize.width), widthMode),
                      height: sanitizeMeasurement(constrainedHeight, Float(measureSize.height), heightMode))
    }

    private static func sanitizeMeasurement(_ constrained: Float, _ measured: Float, _ mode: YGMeasureMode) -> Float {
        switch mode {
        case .exactly:
            return constrained
        case .atMost:
            return min(constrained, measured)
        case .undefined:
            return measured
        @unknown default:
            fatalError()
        }
    }
}

// MARK: - Layout Access
extension FlexLayout {
    @discardableResult
    public final func set(layout: [String: String]) -> Self {
        phrase(map: layout)
        return self
    }

    @discardableResult
    public final func set(layout: String) -> Self {
        phrase(cssString: layout)
        return self
    }

    @discardableResult
    public final func calculateLayout(size: CGSize = CGSize(width: YGValue.undefined.value,
                                                            height: YGValue.undefined.value)) -> CGSize {
        YGNodeCalculateLayout(node,
                              Float(size.width),
                              Float(size.height),
                              YGNodeStyleGetDirection(node))
        return CGSize(width: YGNodeLayoutGetWidth(node),
                      height: YGNodeLayoutGetHeight(node))
    }

    public var frame: CGRect {
        return CGRect(x: YGNodeLayoutGetLeft(node),
                      y: YGNodeLayoutGetTop(node),
                      width: YGNodeLayoutGetWidth(node),
                      height: YGNodeLayoutGetHeight(node))
    }
}

// MARK: - Types
extension FlexLayout {
    public typealias Direction = YGDirection
    public typealias FlexDirection = YGFlexDirection
    public typealias Justify = YGJustify
    public typealias Align = YGAlign
    public typealias Position = YGPositionType
    public typealias Wrap = YGWrap
    public typealias Overflow = YGOverflow
    public typealias Display = YGDisplay
}

extension FlexLayout {
    public typealias Unit = YGUnit
    public typealias Value = YGValue
}

extension FlexLayout.Value {
    public static let auto = YGValueAuto
    public static let undefined = YGValueUndefined
    public static let zero = YGValueZero
}

// MARK: - Basic Properties
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

// MARK: - Size Properties
extension FlexLayout {
    public final var width: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetWidth(node, newValue.value)
            case .percent:
                YGNodeStyleSetWidthPercent(node, newValue.value)
            case .auto:
                YGNodeStyleSetWidthAuto(node)
            case .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetWidth(node) }
    }
    public final var height: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetHeight(node, newValue.value)
            case .percent:
                YGNodeStyleSetHeightPercent(node, newValue.value)
            case .auto:
                YGNodeStyleSetHeightAuto(node)
            case .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetHeight(node) }
    }
}

extension FlexLayout {
    public final var minWidth: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetMinWidth(node, newValue.value)
            case .percent:
                YGNodeStyleSetMinWidthPercent(node, newValue.value)
            case .auto, .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetMinWidth(node) }
    }
    public final var minHeight: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetMinHeight(node, newValue.value)
            case .percent:
                YGNodeStyleSetMinHeightPercent(node, newValue.value)
            case .auto, .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetMinHeight(node) }
    }
    public final var maxWidth: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetMaxWidth(node, newValue.value)
            case .percent:
                YGNodeStyleSetMaxWidthPercent(node, newValue.value)
            case .auto, .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetMaxWidth(node) }
    }
    public final var maxHeight: Value {
        set {
            switch newValue.unit {
            case .point:
                YGNodeStyleSetMaxHeight(node, newValue.value)
            case .percent:
                YGNodeStyleSetMaxHeightPercent(node, newValue.value)
            case .auto, .undefined:
                error("not implemented")
            @unknown default:
                fatalError()
            }
        }
        get { return YGNodeStyleGetMaxHeight(node) }
    }
}

extension FlexLayout {
    public final var aspectRatio: Float {
        set { YGNodeStyleSetAspectRatio(node, newValue) }
        get { return YGNodeStyleGetAspectRatio(node) }
    }
}

// MARK: - Position Properties
extension FlexLayout {
    @inline(__always)
    private func setPosition(_ value: Value, _ edge: YGEdge) {
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
    private func setMargin(_ value: Value, _ edge: YGEdge) {
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
    private func setPadding(_ value: Value, _ edge: YGEdge) {
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

extension FlexLayout {
    public final var left: Value {
        set { setPosition(newValue, .left) }
        get { return YGNodeStyleGetPosition(node, .left) }
    }
    public final var top: Value {
        set { setPosition(newValue, .top) }
        get { return YGNodeStyleGetPosition(node, .top) }
    }
    public final var right: Value {
        set { setPosition(newValue, .right) }
        get { return YGNodeStyleGetPosition(node, .right) }
    }
    public final var bottom: Value {
        set { setPosition(newValue, .bottom) }
        get { return YGNodeStyleGetPosition(node, .bottom) }
    }
    public final var start: Value {
        set { setPosition(newValue, .start) }
        get { return YGNodeStyleGetPosition(node, .start) }
    }
    public final var end: Value {
        set { setPosition(newValue, .end) }
        get { return YGNodeStyleGetPosition(node, .end) }
    }
}

// MARK: - Margin Properties
extension FlexLayout {
    public final var marginLeft: Value {
        set { setMargin(newValue, .left) }
        get { return YGNodeStyleGetMargin(node, .left) }
    }
    public final var marginTop: Value {
        set { setMargin(newValue, .top) }
        get { return YGNodeStyleGetMargin(node, .top) }
    }
    public final var marginRight: Value {
        set { setMargin(newValue, .right) }
        get { return YGNodeStyleGetMargin(node, .right) }
    }
    public final var marginBottom: Value {
        set { setMargin(newValue, .bottom) }
        get { return YGNodeStyleGetMargin(node, .bottom) }
    }
    public final var marginStart: Value {
        set { setMargin(newValue, .start) }
        get { return YGNodeStyleGetMargin(node, .start) }
    }
    public final var marginEnd: Value {
        set { setMargin(newValue, .end) }
        get { return YGNodeStyleGetMargin(node, .end) }
    }
    public final var marginHorizontal: Value {
        set { setMargin(newValue, .horizontal) }
        get { return YGNodeStyleGetMargin(node, .horizontal) }
    }
    public final var marginVertical: Value {
        set { setMargin(newValue, .vertical) }
        get { return YGNodeStyleGetMargin(node, .vertical) }
    }
    public final var margin: Value {
        set { setMargin(newValue, .all) }
        get { return YGNodeStyleGetMargin(node, .all) }
    }
}

// MARK: - Padding Properties
extension FlexLayout {
    public final var paddingLeft: Value {
        set { setPadding(newValue, .left) }
        get { return YGNodeStyleGetPadding(node, .left) }
    }
    public final var paddingTop: Value {
        set { setPadding(newValue, .top) }
        get { return YGNodeStyleGetPadding(node, .top) }
    }
    public final var paddingRight: Value {
        set { setPadding(newValue, .right) }
        get { return YGNodeStyleGetPadding(node, .right) }
    }
    public final var paddingBottom: Value {
        set { setPadding(newValue, .bottom) }
        get { return YGNodeStyleGetPadding(node, .bottom) }
    }
    public final var paddingStart: Value {
        set { setPadding(newValue, .start) }
        get { return YGNodeStyleGetPadding(node, .start) }
    }
    public final var paddingEnd: Value {
        set { setPadding(newValue, .end) }
        get { return YGNodeStyleGetPadding(node, .end) }
    }
    public final var paddingHorizontal: Value {
        set { setPadding(newValue, .horizontal) }
        get { return YGNodeStyleGetPadding(node, .horizontal) }
    }
    public final var paddingVertical: Value {
        set { setPadding(newValue, .vertical) }
        get { return YGNodeStyleGetPadding(node, .vertical) }
    }
    public final var padding: Value {
        set { setPadding(newValue, .all) }
        get { return YGNodeStyleGetPadding(node, .all) }
    }
}

// MARK: - Border Properties
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

// MARK: - Percent Postfix
postfix operator %

extension Int {
    public static postfix func % (value: Int) -> FlexLayout.Value {
        return FlexLayout.Value(value: Float(value), unit: .percent)
    }
}

extension Float {
    public static postfix func % (value: Float) -> FlexLayout.Value {
        return FlexLayout.Value(value: value, unit: .percent)
    }
}

// MARK: - Type Expressible
extension FlexLayout.Direction: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        switch value {
        case "ltr": self = .LTR
        case "rtl": self = .RTL
        case "inherit": self = .inherit
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension FlexLayout.FlexDirection: ExpressibleByStringLiteral {
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

extension FlexLayout.Justify: ExpressibleByStringLiteral {
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

extension FlexLayout.Align: ExpressibleByStringLiteral {
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

extension FlexLayout.Position: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "relative": self = .relative
        case "absolute": self = .absolute
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension FlexLayout.Wrap: ExpressibleByStringLiteral {
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

extension FlexLayout.Overflow: ExpressibleByStringLiteral {
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

extension FlexLayout.Display: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        switch value {
        case "flex": self = .flex
        case "none": self = .none
        default: preconditionFailure("value: \(value) is invalid")
        }
    }
}

extension FlexLayout.Value: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Int) {
        self = FlexLayout.Value(value: Float(value), unit: .point)
    }
}

extension FlexLayout.Value: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    public init(floatLiteral value: Float) {
        self = FlexLayout.Value(value: Float(value), unit: .point)
    }
}

extension FlexLayout.Value: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        var str = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if str == "auto" {
            self = .auto
            return
        } else if str.last == "%" {
            str = String(str.prefix(str.count - 1))
            if let number = Float(str) {
                self = FlexLayout.Value(value: number, unit: .percent)
                return
            }
        } else {
            if let number = Float(str) {
                self = FlexLayout.Value(value: number, unit: .point)
                return
            }
        }
        preconditionFailure("This value: \(value) is not invalid")
    }
}

extension FlexLayout {
    fileprivate struct GuardFloat {
        var value: Swift.Float = 0
    }
}

extension FlexLayout.GuardFloat: ExpressibleByStringLiteral {
    fileprivate typealias StringLiteralType = String
    fileprivate init(stringLiteral value: String) {
        if let float = Swift.Float(value) {
            self = FlexLayout.GuardFloat(value: float)
            return
        }
        preconditionFailure("This value: \(value) is not invalid")
    }
}

// MARK: - Phraser
extension FlexLayout {
    func phrase(cssString: String) {
        guard let map = cssString.cssMap else {
            error("cssString format error")
            return
        }
        phrase(map: map)
    }

    func phrase(map: [String: String]) {
        map.forEach {
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
            case "flex":            flex             = GuardFloat(stringLiteral: $0.value).value
            case "flex-grow":       flexGrow         = GuardFloat(stringLiteral: $0.value).value
            case "flex-shrink":     flexShrink       = GuardFloat(stringLiteral: $0.value).value
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
            case "border-left-width":   borderLeftWidth      = GuardFloat(stringLiteral: $0.value).value
            case "border-top-width":    borderTopWidth       = GuardFloat(stringLiteral: $0.value).value
            case "border-right-width":  borderRightWidth     = GuardFloat(stringLiteral: $0.value).value
            case "border-bottom-width": borderBottomWidth    = GuardFloat(stringLiteral: $0.value).value
            case "border-start-width":  borderStartWidth     = GuardFloat(stringLiteral: $0.value).value
            case "border-end-width":    borderEndWidth       = GuardFloat(stringLiteral: $0.value).value
            case "border-width":        borderWidth          = GuardFloat(stringLiteral: $0.value).value
            // width height
            case "width":           width        = Value(stringLiteral: $0.value)
            case "height":          height       = Value(stringLiteral: $0.value)
            case "min-width":       minWidth     = Value(stringLiteral: $0.value)
            case "min-height":      minHeight    = Value(stringLiteral: $0.value)
            case "max-width":       maxWidth     = Value(stringLiteral: $0.value)
            case "max-height":      maxHeight    = Value(stringLiteral: $0.value)
            case "aspect-ratio":    aspectRatio  = GuardFloat(stringLiteral: $0.value).value
            default:
                error("unkonw flex layout key", $0.key)
            }
        }
    }
}

// MARK: - Channing
extension FlexLayout {
    @discardableResult public func direction        (_ value: Direction)        -> FlexLayout { direction       = value; return self }
    @discardableResult public func flexDirection    (_ value: FlexDirection)    -> FlexLayout { flexDirection   = value; return self }
    @discardableResult public func justifyContent   (_ value: Justify)          -> FlexLayout { justifyContent  = value; return self }
    @discardableResult public func alignContent     (_ value: Align) -> FlexLayout { alignContent       = value; return self }
    @discardableResult public func alignItems       (_ value: Align) -> FlexLayout { alignItems         = value; return self }
    @discardableResult public func alignSelf        (_ value: Align) -> FlexLayout { alignSelf          = value; return self }
    @discardableResult public func position         (_ value: Position) -> FlexLayout { position        = value; return self }
    @discardableResult public func flexWrap         (_ value: Wrap)     -> FlexLayout { flexWrap        = value; return self }
    @discardableResult public func overflow         (_ value: Overflow) -> FlexLayout { overflow        = value; return self }
    @discardableResult public func display          (_ value: Display)  -> FlexLayout { display         = value; return self }
    @discardableResult public func flex             (_ value: Float) -> FlexLayout { flex               = value; return self }
    @discardableResult public func flexGrow         (_ value: Float) -> FlexLayout { flexGrow           = value; return self }
    @discardableResult public func flexShrink       (_ value: Float) -> FlexLayout { flexShrink         = value; return self }
    @discardableResult public func flexBasis        (_ value: Value) -> FlexLayout { flexBasis          = value; return self }
    //position
    @discardableResult public func left             (_ value: Value) -> FlexLayout { left               = value; return self }
    @discardableResult public func top              (_ value: Value) -> FlexLayout { top                = value; return self }
    @discardableResult public func right            (_ value: Value) -> FlexLayout { right              = value; return self }
    @discardableResult public func bottom           (_ value: Value) -> FlexLayout { bottom             = value; return self }
    @discardableResult public func start            (_ value: Value) -> FlexLayout { start              = value; return self }
    @discardableResult public func end              (_ value: Value) -> FlexLayout { end                = value; return self }
    //margin
    @discardableResult public func marginLeft       (_ value: Value) -> FlexLayout { marginLeft         = value; return self }
    @discardableResult public func marginTop        (_ value: Value) -> FlexLayout { marginTop          = value; return self }
    @discardableResult public func marginRight      (_ value: Value) -> FlexLayout { marginRight        = value; return self }
    @discardableResult public func marginBottom     (_ value: Value) -> FlexLayout { marginBottom       = value; return self }
    @discardableResult public func marginStart      (_ value: Value) -> FlexLayout { marginStart        = value; return self }
    @discardableResult public func marginEnd        (_ value: Value) -> FlexLayout { marginEnd          = value; return self }
    @discardableResult public func marginHorizontal (_ value: Value) -> FlexLayout { marginHorizontal   = value; return self }
    @discardableResult public func marginVertical   (_ value: Value) -> FlexLayout { marginVertical     = value; return self }
    @discardableResult public func margin           (_ value: Value) -> FlexLayout { margin             = value; return self }
    //padding
    @discardableResult public func paddingLeft      (_ value: Value) -> FlexLayout { paddingLeft        = value; return self }
    @discardableResult public func paddingTop       (_ value: Value) -> FlexLayout { paddingTop         = value; return self }
    @discardableResult public func paddingRight     (_ value: Value) -> FlexLayout { paddingRight       = value; return self }
    @discardableResult public func paddingBottom    (_ value: Value) -> FlexLayout { paddingBottom      = value; return self }
    @discardableResult public func paddingStart     (_ value: Value) -> FlexLayout { paddingStart       = value; return self }
    @discardableResult public func paddingEnd       (_ value: Value) -> FlexLayout { paddingEnd         = value; return self }
    @discardableResult public func paddingHorizontal(_ value: Value) -> FlexLayout { paddingHorizontal  = value; return self }
    @discardableResult public func paddingVertical  (_ value: Value) -> FlexLayout { paddingVertical    = value; return self }
    @discardableResult public func padding          (_ value: Value) -> FlexLayout { padding            = value; return self }
    // border
    @discardableResult public func borderLeftWidth  (_ value: Float) -> FlexLayout { borderLeftWidth    = value; return self }
    @discardableResult public func borderTopWidth   (_ value: Float) -> FlexLayout { borderTopWidth     = value; return self }
    @discardableResult public func borderRightWidth (_ value: Float) -> FlexLayout { borderRightWidth   = value; return self }
    @discardableResult public func borderBottomWidth(_ value: Float) -> FlexLayout { borderBottomWidth  = value; return self }
    @discardableResult public func borderStartWidth (_ value: Float) -> FlexLayout { borderStartWidth   = value; return self }
    @discardableResult public func borderEndWidth   (_ value: Float) -> FlexLayout { borderEndWidth     = value; return self }
    @discardableResult public func borderWidth      (_ value: Float) -> FlexLayout { borderWidth        = value; return self }
    // width height
    @discardableResult public func width            (_ value: Value) -> FlexLayout { width              = value; return self }
    @discardableResult public func height           (_ value: Value) -> FlexLayout { height             = value; return self }
    @discardableResult public func minWidth         (_ value: Value) -> FlexLayout { minWidth           = value; return self }
    @discardableResult public func minHeight        (_ value: Value) -> FlexLayout { minHeight          = value; return self }
    @discardableResult public func maxWidth         (_ value: Value) -> FlexLayout { maxWidth           = value; return self }
    @discardableResult public func maxHeight        (_ value: Value) -> FlexLayout { maxHeight          = value; return self }
    @discardableResult public func aspectRatio      (_ value: Float) -> FlexLayout { aspectRatio        = value; return self }
}

// MARK: - View access
#if canImport(UIKit)
import UIKit

extension View {
    private static let association = Association<FlexLayout>()
    public var layout: FlexLayout {
        if let layout = View.association[self] {
            return layout
        } else {
            let layout = FlexLayout()
            layout.set(sizeThatFits: sizeThatFits(_:))
            View.association[self] = layout
            return layout
        }
    }

    public final func recursiveSyncFrame() {
        frame = layout.frame
        subviews.forEach {
            $0.recursiveSyncFrame()
        }
    }
}
#endif
