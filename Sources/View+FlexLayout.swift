//  Created by Songwen Ding on 2019/8/11.
//  Copyright © 2019 Songwen Ding. All rights reserved.

import UIKit
import Extension

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
