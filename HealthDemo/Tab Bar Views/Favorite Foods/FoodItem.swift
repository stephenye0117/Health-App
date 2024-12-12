//
//  FavoriteFoodItem.swift
//  Health
//
//  Created by Stephen Ye and Daniel Losada on 12/3/24.
//


import SwiftUI

struct FoodFavoriteItem: View {
    // Input Parameter
    let food: Nutrition
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(food.name.capitalized)
                    .font(.headline)
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(String(format: "%.1f", food.calories)) kcal")
                        Text("\(String(format: "%.1f", food.serving_size_g))g serving")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("P: \(String(format: "%.1f", food.protein_g))g")
                        Text("C: \(String(format: "%.1f", food.carbohydrates_total_g))g")
                        Text("F: \(String(format: "%.1f", food.fat_total_g))g")
                    }
                }
            }
            .font(.system(size: 14))
        }
        .padding(.vertical, 5)
    }
}
