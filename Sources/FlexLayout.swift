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
        if self.isLeaf {
        } else {
            YGNodeSetMeasureFunc(self.yoga.node, nil)
            let children = children.filter({ $0.yoga.isEnabled && $0.yoga.isIncludedInLayout })
            if !FlexLayout.nodeHasExactSameChildren(node: self.yoga.node, children: children) {
                YGNodeRemoveAllChildren(self.yoga.node)
                for index in 0..<children.count {
                    YGNodeInsertChild(self.yoga.node, children[index].yoga.node, UInt32(index))
                }
            }
        }
        return self
    }

    @discardableResult
    public final func set(sizeThatFits: @escaping (CGSize) -> CGSize) -> Self {
        if self.isLeaf {
            self.context = Context(sizeThatFits: sizeThatFits)
            YGNodeSetContext(self.yoga.node, UnsafeMutableRawPointer(&self.context))
            YGNodeSetMeasureFunc(self.yoga.node, FlexLayout.measureFunc)
        } else {
            YGNodeSetMeasureFunc(self.yoga.node, nil)
        }
        return self
    }
}

extension FlexLayout {
    private var isLeaf: Bool {
        if self.yoga.isEnabled
            && self.children.first(where: { $0.yoga.isEnabled && $0.yoga.isIncludedInLayout }) != nil {
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
    public final var intrinsicSize: CGSize {
        return self.calculateLayout(size: CGSize(width: YGValue.undefined.value,
                                                 height: YGValue.undefined.value))
    }

    @discardableResult
    public final func calculateLayout(size: CGSize) -> CGSize {
        let node = self.yoga.node!
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
        let node = self.yoga.node
        let frame = CGRect(x: YGNodeLayoutGetLeft(node),
                           y: YGNodeLayoutGetTop(node),
                           width: YGNodeLayoutGetWidth(node),
                           height: YGNodeLayoutGetHeight(node))
        let topLeft = frame.origin
        let buttomRight = CGPoint(x: frame.maxX, y: frame.maxY)
        return CGRect(x: roundPixel(topLeft.x),
                      y: roundPixel(topLeft.y),
                      width: roundPixel(buttomRight.x) - roundPixel(topLeft.x),
                      height: roundPixel(buttomRight.y) - roundPixel(topLeft.y)
        )
    }
}

// MARK: - programming config
extension FlexLayout {
    public final var direction: CSS.Direction {
        set { self.yoga.direction = newValue } get { return self.yoga.direction }
    }
    public final var flexDirection: CSS.FlexDirection {
        set { self.yoga.flexDirection = newValue } get { return self.yoga.flexDirection }
    }
    public final var justifyContent: CSS.Justify {
        set { self.yoga.justifyContent = newValue } get { return self.yoga.justifyContent }
    }
    public final var alignContent: CSS.Align {
        set { self.yoga.alignContent = newValue } get { return self.yoga.alignContent }
    }
    public final var alignItems: CSS.Align {
        set { self.yoga.alignItems = newValue } get { return self.yoga.alignItems }
    }
    public final var alignSelf: CSS.Align {
        set { self.yoga.alignSelf = newValue } get { return self.yoga.alignSelf }
    }
    public final var position: CSS.Position {
        set { self.yoga.position = newValue } get { return self.yoga.position }
    }
    public final var flexWrap: CSS.Wrap {
        set { self.yoga.flexWrap = newValue } get { return self.yoga.flexWrap }
    }
    public final var overflow: CSS.Overflow {
        set { self.yoga.overflow = newValue } get { return self.yoga.overflow }
    }
    public final var display: CSS.Display {
        set { self.yoga.display = newValue } get { return self.yoga.display }
    }

    public final var flex: CGFloat {
        set { self.yoga.flex = newValue } get { return self.yoga.flex }
    }
    public final var flexGrow: CGFloat {
        set { self.yoga.flexGrow = newValue } get { return self.yoga.flexGrow }
    }
    public final var flexShrink: CGFloat {
        set { self.yoga.flexShrink = newValue } get { return self.yoga.flexShrink }
    }
    public final var flexBasis: CSS.Value {
        set { self.yoga.flexBasis = newValue } get { return self.yoga.flexBasis }
    }

    public final var left: CSS.Value {
        set { self.yoga.left = newValue } get { return self.yoga.left }
    }
    public final var top: CSS.Value {
        set { self.yoga.top = newValue } get { return self.yoga.top }
    }
    public final var right: CSS.Value {
        set { self.yoga.right = newValue } get { return self.yoga.right }
    }
    public final var bottom: CSS.Value {
        set { self.yoga.bottom = newValue } get { return self.yoga.bottom }
    }
    public final var start: CSS.Value {
        set { self.yoga.start = newValue } get { return self.yoga.start }
    }
    public final var end: CSS.Value {
        set { self.yoga.end = newValue } get { return self.yoga.end }
    }

    public final var marginLeft: CSS.Value {
        set { self.yoga.marginLeft = newValue } get { return self.yoga.marginLeft }
    }
    public final var marginTop: CSS.Value {
        set { self.yoga.marginTop = newValue } get { return self.yoga.marginTop }
    }
    public final var marginRight: CSS.Value {
        set { self.yoga.marginRight = newValue } get { return self.yoga.marginRight }
    }
    public final var marginBottom: CSS.Value {
        set { self.yoga.marginBottom = newValue } get { return self.yoga.marginBottom }
    }
    public final var marginStart: CSS.Value {
        set { self.yoga.marginStart = newValue } get { return self.yoga.marginStart }
    }
    public final var marginEnd: CSS.Value {
        set { self.yoga.marginEnd = newValue } get { return self.yoga.marginEnd }
    }
    public final var marginHorizontal: CSS.Value {
        set { self.yoga.marginHorizontal = newValue } get { return self.yoga.marginHorizontal }
    }
    public final var marginVertical: CSS.Value {
        set { self.yoga.marginVertical = newValue } get { return self.yoga.marginVertical }
    }
    public final var margin: CSS.Value {
        set { self.yoga.margin = newValue } get { return self.yoga.margin }
    }

    public final var paddingLeft: CSS.Value {
        set { self.yoga.paddingLeft = newValue } get { return self.yoga.paddingLeft }
    }
    public final var paddingTop: CSS.Value {
        set { self.yoga.paddingTop = newValue } get { return self.yoga.paddingTop }
    }
    public final var paddingRight: CSS.Value {
        set { self.yoga.paddingRight = newValue } get { return self.yoga.paddingRight }
    }
    public final var paddingBottom: CSS.Value {
        set { self.yoga.paddingBottom = newValue } get { return self.yoga.paddingBottom }
    }
    public final var paddingStart: CSS.Value {
        set { self.yoga.paddingStart = newValue } get { return self.yoga.paddingStart }
    }
    public final var paddingEnd: CSS.Value {
        set { self.yoga.paddingEnd = newValue } get { return self.yoga.paddingEnd }
    }
    public final var paddingHorizontal: CSS.Value {
        set { self.yoga.paddingHorizontal = newValue } get { return self.yoga.paddingHorizontal }
    }
    public final var paddingVertical: CSS.Value {
        set { self.yoga.paddingVertical = newValue } get { return self.yoga.paddingVertical }
    }
    public final var padding: CSS.Value {
        set { self.yoga.padding = newValue } get { return self.yoga.padding }
    }

    public final var borderLeftWidth: CGFloat {
        set { self.yoga.borderLeftWidth = newValue } get { return self.yoga.borderLeftWidth }
    }
    public final var borderTopWidth: CGFloat {
        set { self.yoga.borderTopWidth = newValue } get { return self.yoga.borderTopWidth }
    }
    public final var borderRightWidth: CGFloat {
        set { self.yoga.borderRightWidth = newValue } get { return self.yoga.borderRightWidth }
    }
    public final var borderBottomWidth: CGFloat {
        set { self.yoga.borderBottomWidth = newValue } get { return self.yoga.borderBottomWidth }
    }
    public final var borderStartWidth: CGFloat {
        set { self.yoga.borderStartWidth = newValue } get { return self.yoga.borderStartWidth }
    }
    public final var borderEndWidth: CGFloat {
        set { self.yoga.borderEndWidth = newValue } get { return self.yoga.borderEndWidth }
    }
    public final var borderWidth: CGFloat {
        set { self.yoga.borderWidth = newValue } get { return self.yoga.borderWidth }
    }

    public final var width: CSS.Value {
        set { self.yoga.width = newValue } get { return self.yoga.width }
    }
    public final var height: CSS.Value {
        set { self.yoga.height = newValue } get { return self.yoga.height }
    }
    public final var minWidth: CSS.Value {
        set { self.yoga.minWidth = newValue } get { return self.yoga.minWidth }
    }
    public final var minHeight: CSS.Value {
        set { self.yoga.minHeight = newValue } get { return self.yoga.minHeight }
    }
    public final var maxWidth: CSS.Value {
        set { self.yoga.maxWidth = newValue } get { return self.yoga.maxWidth }
    }
    public final var maxHeight: CSS.Value {
        set { self.yoga.maxHeight = newValue } get { return self.yoga.maxHeight }
    }

    public final var aspectRatio: CGFloat {
        set { self.yoga.aspectRatio = newValue } get { return self.yoga.aspectRatio }
    }
    public final var resolvedDirection: CSS.Direction {
        return self.yoga.resolvedDirection
    }
}

// MARK: - dynamic config layout
extension FlexLayout {
    @discardableResult
    public final func set(layout: [String: String]) -> Self {
        layout.forEach { (pair) in
            if let keyPhraser = CSS.keyParaserMap[pair.key] {
                if let value = keyPhraser.phrase(pair.value) {
                    self.yoga.setValue(value, forKey: keyPhraser.key)
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
