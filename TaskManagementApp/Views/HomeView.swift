//
//  HomeView.swift
//  TaskManagementApp
//
//  Created by USER on 05/01/25.
//

import SwiftUI

struct HomeView: View {
    /// Task  Manager Properties
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    
    /// Animation Namespace
    @Namespace private var animation
    
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
//            HStack(spacing: 15) {
//                Button {
//                    showDatePicker.toggle()
//                } label: {
//                    Image(systemName: "calendar")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.black)
//                }
//                Button("Today") {
//                    resetToToday()
//                }
//                .font(.callout)
//                .foregroundColor(.blue)
//            }
            headerView()
            
            ScrollView(.vertical) {
                VStack {
                    
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
        }
        .vSpacing(.top)
        .onAppear {
            handleOnAppear()
        }
//        .sheet(isPresented: $showDatePicker) {
//            VStack {
//                DatePicker(
//                    "Select Date",
//                    selection: $currentDate,
//                    displayedComponents: .date
//                )
//                .datePickerStyle(.graphical)
//                .padding()
//                
//                Button("Set Week") {
//                    updateWeeks(for: currentDate)
//                    showDatePicker = false
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .clipShape(Capsule())
//            }
//            .presentationDetents([.medium])
//        }
    }
    
//    func resetToToday() {
//        currentDate = Date()
//        handleOnAppear()
//        currentWeekIndex = 1
//    }
    
    @ViewBuilder
    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundColor(.darkBlue)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            /// week slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) {
                    index in
                    let week = weekSlider[index]
                    weekView(week: week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
            
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {
            Button {
                
            } label: {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
        })
        .padding(15)
        .background(.white)
        .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
            /// Creating When it reaches first/last page
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
        }
    }
    
    @ViewBuilder
    func weekView(week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundColor(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundColor(isSameDate(day.date, currentDate) ? .white: .gray)
                        .frame(width: 35, height: 35)
                        .background {
                            if isSameDate(day.date, currentDate) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(AppColor.darkBlue.color)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            if day.date.isToday {
                                Circle()
                                    .fill(AppColor.darkBlue.color)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        }
                        .background(.white.shadow(.drop(radius: 1)), in: .rect(cornerRadius: 5))
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        /// When the offset reaches 15 and if the createWeek is toggled then simply generating next set of week
                        /// As we know, each page in the tabview contains 15 pts of padding so the minX will not end at zero
                        /// instead it will end at 15
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        /// safe check
        /// As you notice, new data is created but the position is changed when the new data comes in.
        /// this is happening because, when you go to the 1-0th page and the app adds the previous week at the 0th page,
        /// we're now at the newly added week's data, not at the place we left because the place we left was moved to the 1th index.
        /// Thus setting the index to 1 will solve this issue and the same procedure follows for the next week's data too.
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPrevWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
    func handleOnAppear() {
        if weekSlider.isEmpty {
            let currentWeek = Date().fetchWeek()
            
            if let firstDate = currentWeek.first?.date {
                weekSlider.append(firstDate.createPrevWeek())
            }
            
            weekSlider.append(currentWeek)
            
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }
}

#Preview  {
    ContentView()
}
