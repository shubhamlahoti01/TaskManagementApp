//
//  OffsetKey.swift
//  TaskManagementApp
//
//  Created by USER on 06/01/25.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
