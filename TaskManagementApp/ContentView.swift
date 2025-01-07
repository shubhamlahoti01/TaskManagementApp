//
//  ContentView.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cream)
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}

// some code
