//
//  NutritionDetails.swift
//  Health
//
//  Created by Osman Balci and Daniel Losada on 10/6/24.
//

import SwiftUI
import SwiftData

struct SearchNutritionDetails: View {
    
    // Input Parameter
    let food: Nutrition
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var nutritionsList: [Exercise]
    
    @State private var showAlertMessage = false
    
    var body: some View {
        
        return AnyView(
            // A Form cannot have more than 10 Sections.
            // Group the Sections if more than 10.
            Form {
                Section(header: Text("Name")) {
                    Text(food.name.capitalized)
                }
                Section(header: Text("Add this nutrition to your workout")) {
                    Button(action: {
                        var alreadyInDatabase = false
                        for aNutrition in nutritionsList {
                            if aNutrition.name == food.name {
                                alreadyInDatabase = true
                                break
                            }
                        }
                        
                        if alreadyInDatabase {
                            alertTitle = "Nutrition for this food Already in Database"
                            alertMessage = "This exercise already exists in your nutrition for food favorites list."
                            showAlertMessage = true
                        } else {
                            // Instantiate a new nutrition object and dress it up
                            let newNutrition = Nutrition(name: food.name, calories: food.calories, serving_size_g: food.serving_size_g, fat_total_g: food.fat_total_g, fat_saturated_g: food.fat_saturated_g, protein_g: food.protein_g, sodium_mg: food.sodium_mg, potassium_mg: food.potassium_mg, cholesterol_mg: food.cholesterol_mg, carbohydrates_total_g: food.carbohydrates_total_g, fiber_g: food.fiber_g, sugar_g: food.sugar_g)
                            
                            // Insert the new nutrition object into the database
                            modelContext.insert(newNutrition)
                            
                            alertTitle = "Nutrition for Food Added"
                            alertMessage = "This food's nutrition details are added to your favorites foods list."
                            showAlertMessage = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Add Nutrition Details to Favorites")
                                .font(.system(size: 16))
                        }
                    }
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
                
            }   // End of Form
            .navigationTitle("Selected Nutrition Details")
            .toolbarTitleDisplayMode(.inline)
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            })
            
        )   // End of AnyView
    }   // End of body var
}
