//
//  DatabaseClasses.swift
//  Health
//
//  Created by Adam Hall and Osman Balci on 9/16/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class Nutrition {
    
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
    
    init(name: String, calories: Double, serving_size_g: Double, fat_total_g: Double, fat_saturated_g: Double, protein_g: Double, sodium_mg: Double, potassium_mg: Double, cholesterol_mg: Double, carbohydrates_total_g: Double, fiber_g: Double, sugar_g: Double) {
        self.name = name
        self.calories = calories
        self.serving_size_g = serving_size_g
        self.fat_total_g = fat_total_g
        self.fat_saturated_g = fat_saturated_g
        self.protein_g = protein_g
        self.sodium_mg = sodium_mg
        self.potassium_mg = potassium_mg
        self.cholesterol_mg = cholesterol_mg
        self.carbohydrates_total_g = carbohydrates_total_g
        self.fiber_g = fiber_g
        self.sugar_g = sugar_g
    }
}

@Model
final class Exercise {
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
    
    init(name: String, type: String, muscle: String, equipment: String, difficulty: String, instructions: String) {
        self.name = name
        self.type = type
        self.muscle = muscle
        self.equipment = equipment
        self.difficulty = difficulty
        self.instructions = instructions
    }
}

@Model
class Task {
    var date: Date
    var type: String
    var exercise: ExerciseTask?
    var nutrition: NutritionTask?
    
    init(date: Date, type: String, exercise: ExerciseTask? = nil, nutrition: NutritionTask? = nil) {
        self.date = date
        self.type = type
        self.exercise = exercise
        self.nutrition = nutrition
    }
}

@Model
final class ExerciseTask {
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
    
    init(name: String, type: String, muscle: String, equipment: String, difficulty: String, instructions: String) {
        self.name = name
        self.type = type
        self.muscle = muscle
        self.equipment = equipment
        self.difficulty = difficulty
        self.instructions = instructions
    }
}

@Model
final class NutritionTask {
    
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
    
    init(name: String, calories: Double, serving_size_g: Double, fat_total_g: Double, fat_saturated_g: Double, protein_g: Double, sodium_mg: Double, potassium_mg: Double, cholesterol_mg: Double, carbohydrates_total_g: Double, fiber_g: Double, sugar_g: Double) {
        self.name = name
        self.calories = calories
        self.serving_size_g = serving_size_g
        self.fat_total_g = fat_total_g
        self.fat_saturated_g = fat_saturated_g
        self.protein_g = protein_g
        self.sodium_mg = sodium_mg
        self.potassium_mg = potassium_mg
        self.cholesterol_mg = cholesterol_mg
        self.carbohydrates_total_g = carbohydrates_total_g
        self.fiber_g = fiber_g
        self.sugar_g = sugar_g
    }
}
