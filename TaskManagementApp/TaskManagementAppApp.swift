//
//  TaskManagementAppApp.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import SwiftUI

@main
struct TaskManagementAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
