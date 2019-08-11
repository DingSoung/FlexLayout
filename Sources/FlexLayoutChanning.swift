// Created by Songwen Ding on 2019/8/11.
// Copyright © 2019 Songwen Ding. All rights reserved.

import Foundation

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
