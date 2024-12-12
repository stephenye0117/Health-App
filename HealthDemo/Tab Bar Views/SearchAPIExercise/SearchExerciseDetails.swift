//
//  ExerciseDetails.swift
//  Health
//
//  Created by Adam Hall and Osman Balci and Daniel Losada on 10/6/24.
//

import SwiftUI
import SwiftData

struct SearchExerciseDetails: View {
    
    // Input Parameter
    let exercise: Exercise
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var exercisesList: [Exercise]
    
    @State private var showAlertMessage = false
    
    var body: some View {
        
        return AnyView(
            // A Form cannot have more than 10 Sections.
            // Group the Sections if more than 10.
            Form {
                Section(header: Text("Exercise Name")) {
                    Text(exercise.name.capitalized)
                }
                
                Section(header: Text("Add this exercise to your workout")) {
                    Button(action: {
                        var alreadyInDatabase = false
                        for aExercise in exercisesList {
                            if aExercise.name == exercise.name {
                                alreadyInDatabase = true
                                break
                            }
                        }
                        
                        if alreadyInDatabase {
                            alertTitle = "Exercise Already in Database"
                            alertMessage = "This exercise already exists in your exercise favorites list."
                            showAlertMessage = true
                        } else {
                            // Instantiate a new exercise object and dress it up
                            let newExercise = Exercise(name: exercise.name, type: exercise.type, muscle: exercise.muscle, equipment: exercise.equipment, difficulty: exercise.difficulty, instructions: exercise.instructions)
                            
                            // Insert the new exercise object into the database
                            modelContext.insert(newExercise)
                            
                            alertTitle = "Exercise Added"
                            alertMessage = "This Exercise is added to your exercise favorites list."
                            showAlertMessage = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Add Exercise to Favorites")
                                .font(.system(size: 16))
                        }
                    }
                }
                Section(header: Text("Exercise Type")) {
                    Text(exercise.type.capitalized)
                        
                }
                Section(header: Text("Exercise Muscle")) {
                    Text(exercise.muscle.capitalized)
                }
                Section(header: Text("Exercise Equipment")) {
                    Text(exercise.equipment.capitalized)
                }
                Section(header: Text("Exercise Difficulty")) {
                    Text(exercise.difficulty.capitalized)
                }
                Section(header: Text("Exercise Instructions")) {
                    Text(exercise.instructions)
                }
                
                
            }   // End of Form
            .navigationTitle("Selected Exercise Details")
            .toolbarTitleDisplayMode(.inline)
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            })
            
        )   // End of AnyView
    }   // End of body var
}
