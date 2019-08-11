//  Created by Songwen Ding on 2019/4/16.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation
import CoreGraphics

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
