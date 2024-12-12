//
//  AddTask.swift
//  Health
//
//  Created by Adam Hall, Daniel Losada, and Osman Balci on 12/11/24.
//

import SwiftUI
import SwiftData

struct AddTask: View {
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(FetchDescriptor<Task>()) private var Tasks: [Task]
    @Query(FetchDescriptor<Nutrition>()) private var Nutritions: [Nutrition]
    @Query(FetchDescriptor<Exercise>()) private var Exercises: [Exercise]
    
    @State private var selectedType = 0
    private let typeSelection = ["Exercise", "Food"]
    
    @State private var nameSelected = 0
    
    @State private var selectedDate = Date()
    
    //--------------
    // Alert Message
    //--------------
    @State private var showAlertMessage = false
    
    var body: some View {
        Form {
            Section(header: Text("Select the type")) {
                Picker("", selection: $selectedType) {
                    ForEach(0 ..< typeSelection.count, id: \.self) { index in
                        Text(typeSelection[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            if selectedType == 0 {
                Section(header: Text("Name of the exercise in favoritates")) {
                    Picker("", selection: $nameSelected) {
                        ForEach(0 ..< Exercises.count, id: \.self) { index in
                            Text(Exercises[index].name).tag(index)
                        }
                    }
                }
            }
            else {
                Section(header: Text("Name of the Food in favoritates")) {
                    Picker("", selection: $nameSelected) {
                        ForEach(0 ..< Nutritions.count, id: \.self) { index in
                            Text(Nutritions[index].name).tag(index)
                        }
                    }
                }
            }
            Section(header: Text("Task Date")) {
                DatePicker("Pick a date for the task", selection: $selectedDate)
            }
        } // Form
        .navigationBarTitle("Add Task")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    saveNewTaskToDatabase()
                    
                    showAlertMessage = true
                    alertTitle = "Task Added!"
                    alertMessage = "New task has been successfully added\nto the calendar."
                }) {
                    Text("Save")
                }
            }
        }
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {
                dismiss()
            }
        }, message: {
            Text(alertMessage)
        })
    } // body
    
    /*
    --------------------------------
    MARK: Save New Task to Database
    --------------------------------
    */
    func saveNewTaskToDatabase() {
        var newTask: Task
        if selectedType == 0 {
            for aExercise in Exercises {
                if aExercise == Exercises[nameSelected] {
                    newTask = Task(date: selectedDate, type: "exercise", exercise: ExerciseTask(name: aExercise.name, type: aExercise.type, muscle: aExercise.muscle, equipment: aExercise.equipment, difficulty: aExercise.difficulty, instructions: aExercise.instructions))
                    calendarComponents = [newTask].map {Calendar.current.dateComponents([.year, .month, .day], from: $0.date)}
                    modelContext.insert(newTask)
                    break
                }
            }
        }
        else {
            for aNutrition in Nutritions {
                if aNutrition == Nutritions[nameSelected] {
                    newTask = Task(date: selectedDate, type: "nutrition", nutrition: NutritionTask(name: aNutrition.name, calories: aNutrition.calories, serving_size_g: aNutrition.serving_size_g, fat_total_g: aNutrition.fat_total_g, fat_saturated_g: aNutrition.fat_saturated_g, protein_g: aNutrition.protein_g, sodium_mg: aNutrition.sodium_mg, potassium_mg: aNutrition.potassium_mg, cholesterol_mg: aNutrition.cholesterol_mg, carbohydrates_total_g: aNutrition.carbohydrates_total_g, fiber_g: aNutrition.fiber_g, sugar_g: aNutrition.sugar_g))
                    calendarComponents = [newTask].map {Calendar.current.dateComponents([.year, .month, .day], from: $0.date)}
                    modelContext.insert(newTask)
                    break
                }
            }
        }
    }
}
