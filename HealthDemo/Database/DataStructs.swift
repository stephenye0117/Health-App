//
//  DataStructs.swift
//  Health
//
//  Created by Osman Balci and Adam Hall on 9/16/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI

struct NutritionStruct: Decodable, Hashable {
    
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
}

/*
 2 {
 3    "name": "brisket",
 4    "calories": 1312.3,
 5    "serving_size_g": 453.592,
 6    "fat_total_g": 82.9,
 7    "fat_saturated_g": 33.2,
 8    "protein_g": 132,
 9    "sodium_mg": 217,
 10    "potassium_mg": 781,
 11    "cholesterol_mg": 487,
 12    "carbohydrates_total_g": 0,
 13    "fiber_g": 0,
 14    "sugar_g": 0
 15  },
 */

struct ExercisesStruct: Decodable, Hashable {
    
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}

/*
 {
 3    "name": "Incline Hammer Curls",
 4    "type": "strength",
 5    "muscle": "biceps",
 6    "equipment": "dumbbell",
 7    "difficulty": "beginner",
 8    "instructions": "Seat yourself on an incline bench with a dumbbell in each hand. You should pressed firmly against he back with your feet together. Allow the dumbbells to hang straight down at your side, holding them with a neutral grip. This will be your starting position. Initiate the movement by flexing at the elbow, attempting to keep the upper arm stationary. Continue to the top of the movement and pause, then slowly return to the start position."
 9  }
 */


struct TasksStruct: Decodable, Hashable {
    var date: String
    var name: String
    var type: String
}

/*
 {
   "date": "2024-12-14 14:13:00",
   "name": "Wide-grip barbell curl",
   "type": "exercise"
 }
 */
