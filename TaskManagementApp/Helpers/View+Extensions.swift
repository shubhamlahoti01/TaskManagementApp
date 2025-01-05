//
//  View+Extensions.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import Foundation
import SwiftUI

extension View {
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Checking if two dates are the same
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    @discardableResult func background(_ appColor: AppColor) -> some View {
        return self.background(appColor.color)
    }
    
    @discardableResult func foregroundColor(_ appColor: AppColor) -> some View {
        return self.foregroundColor(appColor.color)
    }
}
