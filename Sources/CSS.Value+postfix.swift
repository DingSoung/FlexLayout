//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics

postfix operator %

extension Int {
    public static postfix func % (value: Int) -> CSS.Value {
        return CSS.Value(value: Float(value), unit: .percent)
    }
}

extension Float {
    public static postfix func % (value: Float) -> CSS.Value {
        return CSS.Value(value: value, unit: .percent)
    }
}

extension CGFloat {
    public static postfix func % (value: CGFloat) -> CSS.Value {
        return CSS.Value(value: Float(value), unit: .percent)
    }
}
