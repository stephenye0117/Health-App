//
//  FavoriteFoodDetails.swift
//  Health
//
//  Created by Stephen Ye and Daniel Losada on 12/3/24.
//


import SwiftUI
import SwiftData

struct FoodFavoriteDetails: View {
    // Input Parameter
    let food: Nutrition
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Food Name")) {
                    Text(food.name.capitalized)
                }
                Section(header: Text("Serving Size")) {
                    Text("\(String(format: "%.1f", food.serving_size_g))g")
                }
                Section(header: Text("Calories")) {
                    Text("\(String(format: "%.1f", food.calories)) kcal")
                }
                Section(header: Text("Macronutrients")) {
                    VStack(alignment: .leading) {
                        Text("Protein: \(String(format: "%.1f", food.protein_g))g")
                        Text("Carbohydrates: \(String(format: "%.1f", food.carbohydrates_total_g))g")
                        Text("Fat: \(String(format: "%.1f", food.fat_total_g))g")
                    }
                }
                Section(header: Text("Detailed Nutrition")) {
                    VStack(alignment: .leading) {
                        Text("Saturated Fat: \(String(format: "%.1f", food.fat_saturated_g))g")
                        Text("Fiber: \(String(format: "%.1f", food.fiber_g))g")
                        Text("Sugar: \(String(format: "%.1f", food.sugar_g))g")
                        Text("Sodium: \(String(format: "%.1f", food.sodium_mg))mg")
                        Text("Potassium: \(String(format: "%.1f", food.potassium_mg))mg")
                        Text("Cholesterol: \(String(format: "%.1f", food.cholesterol_mg))mg")
                    }
                }
            }
        }
        .font(.system(size: 14))
        .navigationTitle("Food Details")
        .toolbarTitleDisplayMode(.inline)
    }
    
    // Helper function to calculate daily value percentage
    func calculateDailyValue(value: Double, recommendedDaily: Double) -> Double {
        return (value / recommendedDaily) * 100
    }
}
