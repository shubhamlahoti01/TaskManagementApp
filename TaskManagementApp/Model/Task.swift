//
//  Task.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    var tintColor: Color {
        switch tint {
        case "red": return Color.red
        case "green": return Color.green
        case "blue": return AppColor.darkBlue.color
        case "yellow": return Color.yellow
        default:
            return .pink
        }
    }
}

//var sampleTasks: [Task] = [
//    .init(taskTitle: "Record Video", creationDate: .updateHour(-5),  isCompleted: true, tint: Color.red.opacity(0.5)),
//    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3),  isCompleted: false, tint: Color.green.opacity(0.5)),
//    .init(taskTitle: "Go for a walk", creationDate: .updateHour(-4),  isCompleted: true, tint: AppColor.darkBlue.color.opacity(0.5)),
//    .init(taskTitle: "Edit Video", creationDate: .updateHour(0),  isCompleted: false, tint: Color.yellow.opacity(0.5)),
//    .init(taskTitle: "Publish Video", creationDate: .updateHour(2),  isCompleted: true, tint: Color.pink.opacity(0.5)),
//    .init(taskTitle: "Tweet about new Video!", creationDate: .updateHour(1),  isCompleted: false, tint: Color.pink.opacity(0.5))
//]

