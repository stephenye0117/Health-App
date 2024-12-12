//
//  FavoriteExerciseDetails.swift
//  Health
//
//  Created by Stephen Ye and Daniel Losada on 12/3/24.
//


import SwiftUI
import SwiftData

struct ExerciseFavoriteDetails: View {
    // Input Parameter
    let exercise: Exercise
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Exercise Name")) {
                    Text(exercise.name.capitalized)
                }
                Section(header: Text("Type")) {
                    Text(exercise.type.capitalized.replacingOccurrences(of: "_", with: " "))
                }
                Section(header: Text("Target Muscle")) {
                    Text(exercise.muscle.capitalized.replacingOccurrences(of: "_", with: " "))
                }
                Section(header: Text("Required Equipment")) {
                    Text(exercise.equipment.isEmpty ? "None" : exercise.equipment.capitalized)
                }
                Section(header: Text("Difficulty Level")) {
                    difficultyView
                }
                Section(header: Text("Instructions")) {
                    Text(exercise.instructions)
                }
            }
        }
        .font(.system(size: 14))
        .navigationTitle("Exercise Details")
        .toolbarTitleDisplayMode(.inline)
    }
    
    var difficultyView: some View {
        HStack {
            Text(exercise.difficulty.capitalized)
            Spacer()
            ForEach(0..<getDifficultyLevel(), id: \.self) { _ in
            }
        }
    }
    
    func getDifficultyLevel() -> Int {
        switch exercise.difficulty.lowercased() {
        case "beginner":
            return 1
        case "intermediate":
            return 2
        case "expert":
            return 3
        default:
            return 0
        }
    }
}
