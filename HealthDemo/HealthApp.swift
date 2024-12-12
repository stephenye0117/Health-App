//
//  HealthApp.swift
//  Health
//
//  Created by Adam Hall and Osman Balci on 12/2/24.
//

import SwiftUI
import SwiftData

@main
struct HealthApp: App {
    init() {
        createDatabase()
    }
    
    // Stores default darkmode setting
    @AppStorage("darkMode") private var darkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                // Checks the perference of darkmode
                .preferredColorScheme(darkMode ? .dark : .light)
                .modelContainer(for: [Nutrition.self, Exercise.self, Task.self, ExerciseTask.self, NutritionTask.self], isUndoEnabled: true)
        }
    }
}
