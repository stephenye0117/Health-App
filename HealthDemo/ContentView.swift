//
//  ContentView.swift
//  Health
//
//  Created by Adam Hall and Daniel Losada and Osman Balci on 12/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            // Give sections and tabs
            Tab("Home", systemImage: "house") {
                Home()
            }
            Tab("Favorite Exercises", systemImage: "dumbbell") {
                ExerciseFavoritesList()
            }
            Tab("Favorite Foods", systemImage: "fork.knife") {
                FoodFavoritesList()
            }
            Tab("Calendar", systemImage: "calendar") {
                CalendarContent()
            }
            Tab("Search Exercise API", systemImage: "magnifyingglass") {
                SearchAPIExercise()
            }
            Tab("Search Nutrition API", systemImage: "magnifyingglass") {
                SearchAPINutrition()
            }
            Tab("Settings", systemImage: "gear") {
                Settings()
            }
        }
        // Allow ipads side bar adaptiability
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
