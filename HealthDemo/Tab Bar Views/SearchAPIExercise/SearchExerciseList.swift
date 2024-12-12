//
//  ExerciseesList.swift
//  Health
//
//  Created by Adam Hall, Daniel Losada, and Osman Balci on 10/6/24.
//

import SwiftUI

struct SearchExercisesList: View {
    var body: some View {
        List {
            // 'id' can be specified as either 'self' or a unique attribute such as 'cca3'
            ForEach(foundExercisesList, id: \.self) { aExercise in
                NavigationLink(destination: SearchExerciseDetails(exercise: aExercise)) {
                    ExerciseFavoriteItem(exercise: aExercise)
                }
            }
        }
        .navigationTitle("Exercise API Search Results")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    SearchExercisesList()
}
