//
//  Task.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var taskTitle: String
    var creationDate: Date = .init()
    var isCompleted: Bool
    var tint: Color
}

var sampleTasks: [Task] = [
    .init(taskTitle: "Record Video", creationDate: .updateHour(-5),  isCompleted: true, tint: Color.red),
    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3),  isCompleted: false, tint: Color.green),
    .init(taskTitle: "Go for a walk", creationDate: .updateHour(-4),  isCompleted: true, tint: AppColor.darkBlue.color),
    .init(taskTitle: "Edit Video", creationDate: .updateHour(0),  isCompleted: false, tint: Color.yellow),
    .init(taskTitle: "Publish Video", creationDate: .updateHour(2),  isCompleted: true, tint: Color.pink),
    .init(taskTitle: "Tweet about new Video!", creationDate: .updateHour(1),  isCompleted: false, tint: Color.pink)
]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
