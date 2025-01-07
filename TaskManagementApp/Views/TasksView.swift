//
//  TasksView.swift
//  TaskManagementApp
//
//  Created by USER on 06/01/25.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Binding var currentDate: Date
    /// swift data dynamc query
    @Query private var tasks: [Task]
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Task> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        let sortDescriptor = [
            SortDescriptor(\Task.creationDate, order: .reverse)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach(tasks) { task in
                TaskRowView(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -35)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
    }
}

#Preview {
    TasksView(currentDate: .constant(.init()))
}

/// Swift predicates can only do certain actions in their predicate block, for more info, check out the swift predicate docs.
/// As we can see, we cant call functions inside the predicate block.
/// Thus, what I m going to do is simply create two dates,
/// one being the start of the selected date and
/// the other being the end of the selected date,
/// and in the predicate block,
/// if the task date lies between these ranges, then it will filter those tasks!
