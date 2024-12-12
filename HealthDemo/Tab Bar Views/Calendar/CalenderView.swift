//
//  CalenderView.swift
//  Health
//
//  Created by Adam Hall and Steward Lynch (https://youtube.com/watch?v=d8KYAeBDQAQ) on 12/10/24.
//

import SwiftUI
import SwiftData
import UIKit

struct CalendarView: UIViewRepresentable {
    let dateInterval: DateInterval
    @Query(FetchDescriptor<Task>()) private var Tasks: [Task]
    @Binding var dateSelected: DateComponents?
    @Binding var displayTasks: Bool
    
    let calendarView = UICalendarView()
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = dateInterval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        _ = Tasks // Allows for update when tasks changes
        uiView.reloadDecorations(forDateComponents: calendarComponents, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarView
        
        init(parent: CalendarView) {
            self.parent = parent
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundTasks = parent.Tasks.filter {$0.date.startOfDay == dateComponents.date?.startOfDay}
            if foundTasks.isEmpty {
                return nil
            }
            else {
                return .image(UIImage(systemName: "circle.fill"), color: .blue)
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else { return }
            let foundTasks = parent.Tasks.filter {$0.date.startOfDay == dateComponents.date?.startOfDay}
            if !foundTasks.isEmpty {
                parent.displayTasks.toggle()
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
    
}
