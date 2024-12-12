//
//  DatabaseCreation.swift
//  Health
//
//  Created by Osman Balci and Adam Hall on 11/11/24.
//  Copyright © 2024 Adam Hall. All rights reserved.
//

import SwiftUI
import SwiftData

public func createDatabase() {
    /*
     ------------------------------------------------
     |   Create Model Container and Model Context   |
     ------------------------------------------------
     */
    var modelContainer: ModelContainer
    
    do {
        // Create a database container to manage the objects
        modelContainer = try ModelContainer(for: Nutrition.self, Exercise.self, Task.self, ExerciseTask.self, NutritionTask.self)
    } catch {
        fatalError("Unable to create ModelContainer")
    }
    
    // Create the context where the objects will be managed
    let modelContext = ModelContext(modelContainer)
    
    /*
     --------------------------------------------------------------------
     |   Check to see if the database has already been created or not   |
     --------------------------------------------------------------------
     */
    let NutritionFetchDescriptor = FetchDescriptor<Nutrition>()
    var listOfAllNutritionsInDatabase = [Nutrition]()
    
    do {
        // Obtain all of the Book objects from the database
        listOfAllNutritionsInDatabase = try modelContext.fetch(NutritionFetchDescriptor)
    } catch {
        fatalError("Unable to fetch Account objects from the database")
    }
    
    if !listOfAllNutritionsInDatabase.isEmpty {
        print("Database has already been created!")
        return
    }
    
    print("Database will be created!")
    
    /*
     ----------------------------------------------------------
     | *** The app is being launched for the first time ***   |
     |   Database needs to be created and populated with      |
     |   the initial content given in the JSON files.         |
     ----------------------------------------------------------
     */
    
    var TasksStruct = [TasksStruct]()
    TasksStruct = decodeJsonFileIntoArrayOfStructs(fullFilename: "DBInitialContent-Task.json", fileLocation: "Main Bundle")
    
    /*
     ******************************************************
     *   Create Nutrition in the Database   *
     ******************************************************
     */
    var NutritionStructList = [NutritionStruct]()
    NutritionStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "DBInitialContent-Nutrition.json", fileLocation: "Main Bundle")
    
    for aNutrition in NutritionStructList {

        let newNutrition = Nutrition(name: aNutrition.name, calories: aNutrition.calories, serving_size_g: aNutrition.serving_size_g, fat_total_g: aNutrition.fat_total_g, fat_saturated_g: aNutrition.fat_saturated_g, protein_g: aNutrition.protein_g, sodium_mg: aNutrition.sodium_mg, potassium_mg: aNutrition.potassium_mg, cholesterol_mg: aNutrition.cholesterol_mg, carbohydrates_total_g: aNutrition.carbohydrates_total_g, fiber_g: aNutrition.fiber_g, sugar_g: aNutrition.sugar_g)
        
        for aTask in TasksStruct {
            if aTask.name == newNutrition.name {
                let Formatter = DateFormatter()
                Formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = Formatter.date(from: aTask.date)!
                
                let newNutritionTask = NutritionTask(name: aNutrition.name, calories: aNutrition.calories, serving_size_g: aNutrition.serving_size_g, fat_total_g: aNutrition.fat_total_g, fat_saturated_g: aNutrition.fat_saturated_g, protein_g: aNutrition.protein_g, sodium_mg: aNutrition.sodium_mg, potassium_mg: aNutrition.potassium_mg, cholesterol_mg: aNutrition.cholesterol_mg, carbohydrates_total_g: aNutrition.carbohydrates_total_g, fiber_g: aNutrition.fiber_g, sugar_g: aNutrition.sugar_g)
                
                let newTask = Task(date: date, type: aTask.type, nutrition: newNutritionTask)
                
                modelContext.insert(newTask)
                break
            }
        }
        
        print(newNutrition.name)
        modelContext.insert(newNutrition)
        
    }   // End of the for loop
    
    /*
     ******************************************************
     *   Create Exercises in the Database   *
     ******************************************************
     */
    var ExercisesStructList = [ExercisesStruct]()
    ExercisesStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "DBInitialContent-Exercises.json", fileLocation: "Main Bundle")
    
    for aExercise in ExercisesStructList {

        let newExercise = Exercise(name: aExercise.name, type: aExercise.type, muscle: aExercise.muscle, equipment: aExercise.equipment, difficulty: aExercise.difficulty, instructions: aExercise.instructions)
        
        for aTask in TasksStruct {
            if aTask.name == newExercise.name {
                let Formatter = DateFormatter()
                Formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = Formatter.date(from: aTask.date)!
                
                let newExerciseTask = ExerciseTask(name: aExercise.name, type: aExercise.type, muscle: aExercise.muscle, equipment: aExercise.equipment, difficulty: aExercise.difficulty, instructions: aExercise.instructions)
                
                let newTask = Task(date: date, type: aTask.type, exercise: newExerciseTask)
                modelContext.insert(newTask)
                break
            }
        }
        
        modelContext.insert(newExercise)
        
    }   // End of the for loop
    
    /*
     =================================
     |   Save All Database Changes   |
     =================================
     🔴 NOTE: Database changes are automatically saved and SwiftUI Views are
     automatically refreshed upon State change in the UI or after a certain time period.
     But sometimes, you can manually save the database changes just to be sure.
     */
    do {
        try modelContext.save()
    } catch {
        fatalError("Unable to save database changes")
    }
    
    print("Database is successfully created!")
}

