//
//  Calendar.swift
//  Health
//
//  Created by Adam Hall and Steward Lynch (https://youtube.com/watch?v=d8KYAeBDQAQ) on 12/10/24.
//

import SwiftUI
import SwiftData


struct CalendarContent: View {
    @State private var dateSelected: DateComponents?
    @State private var displayTasks = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(dateInterval: DateInterval(start: .distantPast, end: .distantFuture), dateSelected: $dateSelected, displayTasks: $displayTasks)
                    .navigationTitle("Calendar")
                    .toolbarTitleDisplayMode(.inline)
            }
            .navigationDestination(isPresented: $displayTasks) {
                DaysTasksList(dateSelected: $dateSelected)
            }
            .toolbar {
                // Place the Add (+) button on right side of the toolbar
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddTask()) {
                        Image(systemName: "plus")
                    }
                }
            }   // End of toolbar
        }
    }
}

#Preview {
    CalendarContent()
}
