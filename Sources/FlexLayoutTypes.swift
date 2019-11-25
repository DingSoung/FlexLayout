//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics
import YogaKit

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
