//
//  AppColor.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import SwiftUI

enum AppColor {
    case cream, darkBlue
    var color: Color {
        switch self {
        case .cream: return Color(hex: "#f2f4f7")
        case .darkBlue: return Color(hex: "#0a1e40")
        }
    }
}
