//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import UIKit
import Extension

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
        YGConfigSetPointScaleFactor(globalConfig, Float(UIScreen.main.scale))
        return YGNodeNewWithConfig(globalConfig)
    }()

    private var children = [FlexLayout]()

    public init() {}
}

// MARK: - structure
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
            YGNodeSetContext(node, UnsafeMutableRawPointer(&context))
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

// MARK: - layout access
extension FlexLayout {
    @discardableResult
    public final func set(layout: [String: String]) -> Self {
        FlexLayoutPhraser.phrase(layout: self, map: layout)
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
