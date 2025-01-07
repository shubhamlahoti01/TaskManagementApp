//
//  TaskRowView.swift
//  TaskManagementApp
//
//  Created by USER on 06/01/25.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver) /// to make the button tap more accessible, adding an invisible layer to receive the taps
                        .onTapGesture {
                            task.isCompleted.toggle()
                        }
                }
            VStack(alignment: .leading, spacing: 8) {
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Label(task.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding(15)
            .hSpacing(.leading)
            .background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .offset(y: -8)
        }
    }
    
    var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        return task.creationDate.isSameHour ? AppColor.darkBlue.color : (task.creationDate.isPast ? .red : .black)
    }
}

#Preview {
//    TaskRowView(task: .constant(sampleTasks[0]))
    ContentView()
}
