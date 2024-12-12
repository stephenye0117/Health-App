//
//  FavoriteExerciseItem.swift
//  Health
//
//  Created by Stephen Ye and Daniel Losada on 12/3/24.
//


import SwiftUI

struct ExerciseFavoriteItem: View {
    // Input Parameter
    let exercise: Exercise
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(exercise.name.capitalized)
                    .font(.headline)
                HStack {
                    Image(systemName: getMuscleIcon())
                        .foregroundColor(.blue)
                    Text(exercise.muscle.capitalized.replacingOccurrences(of: "_", with: " "))
                    Spacer()
                    Text(exercise.difficulty.capitalized)
                        .foregroundColor(getDifficultyColor())
                }
                Text(exercise.type.capitalized.replacingOccurrences(of: "_", with: " "))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .font(.system(size: 14))
        }
        .padding(.vertical, 5)
    }
    
    func getMuscleIcon() -> String {
        switch exercise.muscle.lowercased() {
        case "abdominals":
            return "figure.core.training"
        case "biceps":
            return "figure.strengthtraining.traditional"
        case "chest":
            return "figure.boxing"
        case "legs":
            return "figure.run"
        default:
            return "figure.mixed.cardio"
        }
    }
    
    func getDifficultyColor() -> Color {
        switch exercise.difficulty.lowercased() {
        case "beginner":
            return .green
        case "intermediate":
            return .orange
        case "expert":
            return .red
        default:
            return .gray
        }
    }
}
