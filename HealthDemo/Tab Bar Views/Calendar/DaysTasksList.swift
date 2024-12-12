//
//  DaysTasksList.swift
//  Health
//
//  Created by Adam Hall and Osman Balci on 12/10/24.
//

import SwiftUI
import SwiftData

struct DaysTasksList: View {
    @Binding var dateSelected: DateComponents?
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(FetchDescriptor<Task>(sortBy: [SortDescriptor(\Task.date, order: .forward)])) private var Tasks: [Task]
    
    @State var selectedFilter = 0
    private let filterType: [String] = ["All", "Exercise", "Nutrition"]
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            NavigationStack {
                VStack {
                    Picker("", selection: $selectedFilter) {
                        ForEach(0 ..< filterType.count, id: \.self) { index in
                            Text(filterType[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .navigationTitle("Days Task List")
                    .toolbarTitleDisplayMode(.inline)
                    
                    List {
                        ForEach(filteredTasks) { aTask in
                            NavigationLink(destination: details(task: aTask)) {
                                HStack {
                                    Text(aTask.date, style: .time)
                                    items(task: aTask)
                                }
                                .alert(isPresented: $showConfirmation) {
                                    Alert(title: Text("Delete Confirmation"),
                                          message: Text("Are you sure to permanently delete this task?"),
                                          primaryButton: .destructive(Text("Delete")) {
                                            if let index = toBeDeleted?.first {
                                                let taskToDelete = filteredTasks[index]
                                                calendarComponents = [taskToDelete].map {Calendar.current.dateComponents([.year, .month, .day], from: $0.date)}
                                                modelContext.delete(taskToDelete)
                                            }
                                            toBeDeleted = nil
                                        }, secondaryButton: .cancel() {
                                            toBeDeleted = nil
                                        }
                                    )
                                }
                            }
                        } // End of ForEach
                        .onDelete(perform: delete)
                    } // End of List
                    .toolbar {
                        // Place the Edit button on left side of the toolbar
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }
                    }
                }
            } // end of navi stack
        }
    } // end of body
    
    private func details(task: Task) -> some View {
        if task.type == "exercise" {
            let aExercise = task.exercise!
            return AnyView(ExerciseFavoriteDetails(exercise: Exercise(name: aExercise.name, type: aExercise.type, muscle: aExercise.muscle, equipment: aExercise.equipment, difficulty: aExercise.difficulty, instructions: aExercise.instructions)))
        }
        else {
            let aNutrition = task.nutrition!
            return AnyView(FoodFavoriteDetails(food: Nutrition(name: aNutrition.name, calories: aNutrition.calories, serving_size_g: aNutrition.serving_size_g, fat_total_g: aNutrition.fat_total_g, fat_saturated_g: aNutrition.fat_saturated_g, protein_g: aNutrition.protein_g, sodium_mg: aNutrition.sodium_mg, potassium_mg: aNutrition.potassium_mg, cholesterol_mg: aNutrition.cholesterol_mg, carbohydrates_total_g: aNutrition.carbohydrates_total_g, fiber_g: aNutrition.fiber_g, sugar_g: aNutrition.sugar_g)))
        }
    }
    
    private func items(task: Task) -> some View {
        if task.type == "exercise" {
            let aExercise = task.exercise!
            return AnyView(ExerciseFavoriteItem(exercise: Exercise(name: aExercise.name, type: aExercise.type, muscle: aExercise.muscle, equipment: aExercise.equipment, difficulty: aExercise.difficulty, instructions: aExercise.instructions)))
        }
        else {
            let aNutrition = task.nutrition!
            return AnyView(FoodFavoriteItem(food: Nutrition(name: aNutrition.name, calories: aNutrition.calories, serving_size_g: aNutrition.serving_size_g, fat_total_g: aNutrition.fat_total_g, fat_saturated_g: aNutrition.fat_saturated_g, protein_g: aNutrition.protein_g, sodium_mg: aNutrition.sodium_mg, potassium_mg: aNutrition.potassium_mg, cholesterol_mg: aNutrition.cholesterol_mg, carbohydrates_total_g: aNutrition.carbohydrates_total_g, fiber_g: aNutrition.fiber_g, sugar_g: aNutrition.sugar_g)))
        }
    }
    
    private var filteredTasks: [Task] {
        if let dateSelected = dateSelected {
            if selectedFilter == 0 {
                return Tasks.filter {$0.date.startOfDay == dateSelected.date!.startOfDay}
            }
            else if selectedFilter == 1 {
                return Tasks.filter {$0.date.startOfDay == dateSelected.date!.startOfDay && $0.type == "exercise"}
            }
            else if selectedFilter == 2 {
                return Tasks.filter {$0.date.startOfDay == dateSelected.date!.startOfDay && $0.type == "nutrition"}
            }
        }
        return []
    }
    
    /*
     ---------------------------
     MARK: Delete Selected Video
     ---------------------------
     */
    private func delete(offsets: IndexSet) {
        toBeDeleted = offsets
        showConfirmation = true
    }
}
