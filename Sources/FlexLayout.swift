//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics
import Extension

@objcMembers
open class FlexLayout: NSObject {
    private class Context {
        var sizeThatFits: (CGSize) -> CGSize
        init(sizeThatFits: @escaping (CGSize) -> CGSize) {
            self.sizeThatFits = sizeThatFits
        }
    }

    private var context: Context?

    private lazy var yoga: YGLayout = {
        let yoga = YGLayout()
        yoga.isEnabled = true
        // Flex Layout Guide: http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html
        return yoga
    }()

    private var children = [FlexLayout]()
}

extension FlexLayout {
    @discardableResult
    public final func set(children: [FlexLayout]) -> Self {
        self.children = children
        if isLeaf {
        } else {
            YGNodeSetMeasureFunc(yoga.node, nil)
            let children = children.filter({ $0.yoga.isEnabled && $0.yoga.isIncludedInLayout })
            if !FlexLayout.nodeHasExactSameChildren(node: yoga.node, children: children) {
                YGNodeRemoveAllChildren(yoga.node)
                for index in 0..<children.count {
                    YGNodeInsertChild(yoga.node, children[index].yoga.node, UInt32(index))
                }
            }
        }
        return self
    }

    @discardableResult
    public final func set(sizeThatFits: @escaping (CGSize) -> CGSize) -> Self {
        if isLeaf {
            context = Context(sizeThatFits: sizeThatFits)
            YGNodeSetContext(yoga.node, UnsafeMutableRawPointer(&context))
            YGNodeSetMeasureFunc(yoga.node, FlexLayout.measureFunc)
        } else {
            YGNodeSetMeasureFunc(yoga.node, nil)
        }
        return self
    }
}

extension FlexLayout {
    private var isLeaf: Bool {
        if yoga.isEnabled
            && children.first(where: { $0.yoga.isEnabled && $0.yoga.isIncludedInLayout }) != nil {
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
            if YGNodeGetChild(node, UInt32(index)) != children[index].yoga.node {
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

// MARK: - layout access
extension FlexLayout {
    @discardableResult
    public final func calculateLayout(size: CGSize = CGSize(width: YGValue.undefined.value,
                                                            height: YGValue.undefined.value)) -> CGSize {
        let node = yoga.node!
        YGNodeCalculateLayout(node,
                              Float(size.width),
                              Float(size.height),
                              YGNodeStyleGetDirection(node))
        return CGSize(width: YGNodeLayoutGetWidth(node),
                      height: YGNodeLayoutGetHeight(node))
    }

    private static let screenScale = UIScreen.main.scale
    @inline(__always)
    private final func roundPixel(_ value: CGFloat) -> CGFloat {
        return ceil(value * FlexLayout.screenScale) / FlexLayout.screenScale
    }

    public var frame: CGRect {
        let node = yoga.node
        return CGRect(x: YGNodeLayoutGetLeft(node),
                      y: YGNodeLayoutGetTop(node),
                      width: YGNodeLayoutGetWidth(node),
                      height: YGNodeLayoutGetHeight(node))
    }
}

// MARK: - programming config
extension FlexLayout {
    public final var direction: CSS.Direction {
        set { yoga.direction = newValue } get { return yoga.direction }
    }
    public final var flexDirection: CSS.FlexDirection {
        set { yoga.flexDirection = newValue } get { return yoga.flexDirection }
    }
    public final var justifyContent: CSS.Justify {
        set { yoga.justifyContent = newValue } get { return yoga.justifyContent }
    }
    public final var alignContent: CSS.Align {
        set { yoga.alignContent = newValue } get { return yoga.alignContent }
    }
    public final var alignItems: CSS.Align {
        set { yoga.alignItems = newValue } get { return yoga.alignItems }
    }
    public final var alignSelf: CSS.Align {
        set { yoga.alignSelf = newValue } get { return yoga.alignSelf }
    }
    public final var position: CSS.Position {
        set { yoga.position = newValue } get { return yoga.position }
    }
    public final var flexWrap: CSS.Wrap {
        set { yoga.flexWrap = newValue } get { return yoga.flexWrap }
    }
    public final var overflow: CSS.Overflow {
        set { yoga.overflow = newValue } get { return yoga.overflow }
    }
    public final var display: CSS.Display {
        set { yoga.display = newValue } get { return yoga.display }
    }

    public final var flex: CGFloat {
        set { yoga.flex = newValue } get { return yoga.flex }
    }
    public final var flexGrow: CGFloat {
        set { yoga.flexGrow = newValue } get { return yoga.flexGrow }
    }
    public final var flexShrink: CGFloat {
        set { yoga.flexShrink = newValue } get { return yoga.flexShrink }
    }
    public final var flexBasis: CSS.Value {
        set { yoga.flexBasis = newValue } get { return yoga.flexBasis }
    }

    public final var left: CSS.Value {
        set { yoga.left = newValue } get { return yoga.left }
    }
    public final var top: CSS.Value {
        set { yoga.top = newValue } get { return yoga.top }
    }
    public final var right: CSS.Value {
        set { yoga.right = newValue } get { return yoga.right }
    }
    public final var bottom: CSS.Value {
        set { yoga.bottom = newValue } get { return yoga.bottom }
    }
    public final var start: CSS.Value {
        set { yoga.start = newValue } get { return yoga.start }
    }
    public final var end: CSS.Value {
        set { yoga.end = newValue } get { return yoga.end }
    }

    public final var marginLeft: CSS.Value {
        set { yoga.marginLeft = newValue } get { return yoga.marginLeft }
    }
    public final var marginTop: CSS.Value {
        set { yoga.marginTop = newValue } get { return yoga.marginTop }
    }
    public final var marginRight: CSS.Value {
        set { yoga.marginRight = newValue } get { return yoga.marginRight }
    }
    public final var marginBottom: CSS.Value {
        set { yoga.marginBottom = newValue } get { return yoga.marginBottom }
    }
    public final var marginStart: CSS.Value {
        set { yoga.marginStart = newValue } get { return yoga.marginStart }
    }
    public final var marginEnd: CSS.Value {
        set { yoga.marginEnd = newValue } get { return yoga.marginEnd }
    }
    public final var marginHorizontal: CSS.Value {
        set { yoga.marginHorizontal = newValue } get { return yoga.marginHorizontal }
    }
    public final var marginVertical: CSS.Value {
        set { yoga.marginVertical = newValue } get { return yoga.marginVertical }
    }
    public final var margin: CSS.Value {
        set { yoga.margin = newValue } get { return yoga.margin }
    }

    public final var paddingLeft: CSS.Value {
        set { yoga.paddingLeft = newValue } get { return yoga.paddingLeft }
    }
    public final var paddingTop: CSS.Value {
        set { yoga.paddingTop = newValue } get { return yoga.paddingTop }
    }
    public final var paddingRight: CSS.Value {
        set { yoga.paddingRight = newValue } get { return yoga.paddingRight }
    }
    public final var paddingBottom: CSS.Value {
        set { yoga.paddingBottom = newValue } get { return yoga.paddingBottom }
    }
    public final var paddingStart: CSS.Value {
        set { yoga.paddingStart = newValue } get { return yoga.paddingStart }
    }
    public final var paddingEnd: CSS.Value {
        set { yoga.paddingEnd = newValue } get { return yoga.paddingEnd }
    }
    public final var paddingHorizontal: CSS.Value {
        set { yoga.paddingHorizontal = newValue } get { return yoga.paddingHorizontal }
    }
    public final var paddingVertical: CSS.Value {
        set { yoga.paddingVertical = newValue } get { return yoga.paddingVertical }
    }
    public final var padding: CSS.Value {
        set { yoga.padding = newValue } get { return yoga.padding }
    }

    public final var borderLeftWidth: CGFloat {
        set { yoga.borderLeftWidth = newValue } get { return yoga.borderLeftWidth }
    }
    public final var borderTopWidth: CGFloat {
        set { yoga.borderTopWidth = newValue } get { return yoga.borderTopWidth }
    }
    public final var borderRightWidth: CGFloat {
        set { yoga.borderRightWidth = newValue } get { return yoga.borderRightWidth }
    }
    public final var borderBottomWidth: CGFloat {
        set { yoga.borderBottomWidth = newValue } get { return yoga.borderBottomWidth }
    }
    public final var borderStartWidth: CGFloat {
        set { yoga.borderStartWidth = newValue } get { return yoga.borderStartWidth }
    }
    public final var borderEndWidth: CGFloat {
        set { yoga.borderEndWidth = newValue } get { return yoga.borderEndWidth }
    }
    public final var borderWidth: CGFloat {
        set { yoga.borderWidth = newValue } get { return yoga.borderWidth }
    }

    public final var width: CSS.Value {
        set { yoga.width = newValue } get { return yoga.width }
    }
    public final var height: CSS.Value {
        set { yoga.height = newValue } get { return yoga.height }
    }
    public final var minWidth: CSS.Value {
        set { yoga.minWidth = newValue } get { return yoga.minWidth }
    }
    public final var minHeight: CSS.Value {
        set { yoga.minHeight = newValue } get { return yoga.minHeight }
    }
    public final var maxWidth: CSS.Value {
        set { yoga.maxWidth = newValue } get { return yoga.maxWidth }
    }
    public final var maxHeight: CSS.Value {
        set { yoga.maxHeight = newValue } get { return yoga.maxHeight }
    }

    public final var aspectRatio: CGFloat {
        set { yoga.aspectRatio = newValue } get { return yoga.aspectRatio }
    }
    public final var resolvedDirection: CSS.Direction {
        return yoga.resolvedDirection
    }
}

// MARK: - dynamic config layout
extension FlexLayout {
    @discardableResult
    public final func set(layout: [String: String]) -> Self {
        layout.forEach { (pair) in
            if let keyPhraser = CSS.keyParaserMap[pair.key] {
                if let value = keyPhraser.phrase(pair.value) {
                    yoga.setValue(value, forKey: keyPhraser.key)
                } else {
                    error("can not phrase style:", pair)
                }
            } else {
                error("no phraser for style:", pair)
            }
        }
        return self
    }
}

extension YGLayout {
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        super.setValue(value, forUndefinedKey: key)
        error("can not apply style:", key, value ?? "nil")
    }
}
