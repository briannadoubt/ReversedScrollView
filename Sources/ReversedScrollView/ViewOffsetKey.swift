//
//  ViewOffsetKey.swift
//  ReversedScrollView
//
//  Created by Bri on 12/30/21.
//

import SwiftUI

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
