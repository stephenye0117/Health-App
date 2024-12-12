//
//  Home.swift
//  Health
//
//  Created by Adam Hall, Stephen Ye, Daniel Losada, and Osman Balci on 9/30/24.
//  Copyright © 2024 Adam Hall. All rights reserved.
//

import SwiftUI
import SwiftData
import Charts

struct Home: View {
    @Query(FetchDescriptor<Task>(
        sortBy: [SortDescriptor(\Task.date, order: .forward)])
    ) private var tasks: [Task]
    
    @State private var index = 0
    private let items = ["Exercise1", "Food1", "Exercise2", "Food2"]
    private let descriptions = [
        "High-intensity interval training",
        "Balanced nutrition plate",
        "Strength training basics",
        "Healthy meal prep"
    ]
    
    let chartTypes = ["Bar", "Line"]
    @State private var selectedChartTypeIndex = 0
    
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("Welcome")
                    .padding()
                
                Image(items[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .padding()
                    .onReceive(timer) { _ in
                        index = (index + 1) % items.count
                    }
                
                Text(descriptions[index])
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Form {
                    Section(header: Text("Select Chart Type")) {
                        Picker("Chart Types", selection: $selectedChartTypeIndex) {
                            ForEach(0 ..< chartTypes.count, id: \.self) {
                                Text(chartTypes[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    if selectedChartTypeIndex == 0 {
                        Section {
                            Chart {
                                ForEach(calorieData) { day in
                                    BarMark(
                                        x: .value("Date", day.date),
                                        y: .value("Calories", day.calories)
                                    )
                                    .foregroundStyle(.blue)
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                                //chartYAxisLabel(Text(""))
                            }
                            .frame(height: 300)
                        }
                    }
                    if selectedChartTypeIndex == 1 {
                        Section {
                            Chart {
                                ForEach(calorieData) { day in
                                    LineMark(
                                        x: .value("Date", day.date),
                                        y: .value("Calories", day.calories)
                                    )
                                    .foregroundStyle(.blue)
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 300)
                        }
                    }
                }
                .frame(height: 500)
                
                Text("Powered By")
                    .font(.system(size: 18, weight: .light, design: .serif))
                    .italic()
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                
                Link(destination: URL(string: "https://api-ninjas.com/api/")!) {
                    HStack {
                        Image("apininjas_logo")
                            .resizable()
                            .frame(width: 150, height: 40)
                        Text("API Ninjas")
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .onAppear() {
            startTimer()
        }
        .onDisappear() {
            stopTimer()
        }
    }
    
    struct DayCalories: Identifiable {
        let id = UUID()
        let date: String
        let calories: Double
    }
    
    var calorieData: [DayCalories] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: "2024-12-11")!
        let endDate = dateFormatter.date(from: "2024-12-18")!
        
        var dailyCalories: [DayCalories] = []
        dateFormatter.dateFormat = "MM/dd"
        
        for date in stride(from: startDate, through: endDate, by: 86400) {
            let dayStart = Calendar.current.startOfDay(for: date)
            let dayTasks = tasks.filter {
                Calendar.current.startOfDay(for: $0.date) == dayStart &&
                $0.type == "nutrition"
            }
            
            let totalCalories = dayTasks.reduce(0.0) { sum, task in
                sum + (task.nutrition?.calories ?? 0)
            }
            
            dailyCalories.append(DayCalories(
                date: dateFormatter.string(from: date),
                calories: totalCalories
            ))
        }
        
        return dailyCalories
    }
    
    func startTimer() {
        timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}
