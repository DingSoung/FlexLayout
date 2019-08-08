//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import CoreGraphics
import Extension

extension FlexLayout {
    public final var width: CSS.Value {
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
    public final var height: CSS.Value {
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
    public final var minWidth: CSS.Value {
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
    public final var minHeight: CSS.Value {
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
    public final var maxWidth: CSS.Value {
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
    public final var maxHeight: CSS.Value {
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
    
    public final var aspectRatio: CGFloat {
        set { YGNodeStyleSetAspectRatio(node, newValue.float) }
        get { return YGNodeStyleGetAspectRatio(node).cgFloat }
    }
}
