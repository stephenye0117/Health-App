//
//  FavoritesExerciseList.swift
//  Health
//
//  Created by Stephen Ye and Osman Balci on 12/3/24.
//


import SwiftUI
import SwiftData

struct ExerciseFavoritesList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Exercise>(sortBy: [SortDescriptor(\Exercise.name, order: .forward)])) private var listOfAllExercisesInDatabase: [Exercise]
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    @State private var searchText = ""
    @State private var selectedMuscleFilter = "All"
    @State private var selectedDifficultyFilter = "All"
    
    let muscleGroups = ["All", "Abdominals", "Biceps", "Calves", "Chest", "Forearms", "Glutes", "Hamstrings", "Lats", "Lower_back", "Middle_back", "Neck", "Quadriceps", "Traps", "Triceps"]
    let difficultyLevels = ["All", "Beginner", "Intermediate", "Expert"]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Filters
                HStack {
                    Picker("Muscle", selection: $selectedMuscleFilter) {
                        ForEach(muscleGroups, id: \.self) { muscle in
                            Text(muscle.replacingOccurrences(of: "_", with: " ").capitalized)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Difficulty", selection: $selectedDifficultyFilter) {
                        ForEach(difficultyLevels, id: \.self) { level in
                            Text(level)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding()
                
                List {
                    ForEach(filteredExercises) { anExercise in
                        NavigationLink(destination: ExerciseFavoriteDetails(exercise: anExercise)) {
                            ExerciseFavoriteItem(exercise: anExercise)
                                .alert(isPresented: $showConfirmation) {
                                    Alert(title: Text("Delete Confirmation"),
                                          message: Text("Are you sure to permanently delete this exercise?"),
                                          primaryButton: .destructive(Text("Delete")) {
                                                if let index = toBeDeleted?.first {
                                                    let exerciseToDelete = listOfAllExercisesInDatabase[index]
                                                    modelContext.delete(exerciseToDelete)
                                                }
                                                toBeDeleted = nil
                                          }, secondaryButton: .cancel() {
                                                toBeDeleted = nil
                                          }
                                    )
                                }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .font(.system(size: 14))
            .navigationTitle("Favorite Exercises")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search Favorite Exercises")
    }
    
    var filteredExercises: [Exercise] {
        var exercises = listOfAllExercisesInDatabase
        
        // Apply muscle filter
        if selectedMuscleFilter != "All" {
            exercises = exercises.filter { $0.muscle.lowercased() == selectedMuscleFilter.lowercased() }
        }
        
        // Apply difficulty filter
        if selectedDifficultyFilter != "All" {
            exercises = exercises.filter { $0.difficulty.lowercased() == selectedDifficultyFilter.lowercased() }
        }
        
        // Apply search text
        if !searchText.isEmpty {
            exercises = exercises.filter {
                $0.name.localizedStandardContains(searchText) ||
                $0.type.localizedStandardContains(searchText) ||
                $0.muscle.localizedStandardContains(searchText) ||
                $0.instructions.localizedStandardContains(searchText)
            }
        }
        
        return exercises
    }
    
    func delete(at offsets: IndexSet) {
        toBeDeleted = offsets
        showConfirmation = true
    }
}
