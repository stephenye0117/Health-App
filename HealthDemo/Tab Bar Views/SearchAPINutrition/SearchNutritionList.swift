//
//  SearchNutritionList.swift
//  Health
//
//  Created by Adam Hall, Daniel Losada and Osman Balci on 10/6/24.
//

import SwiftUI

struct SearchNutritionList: View {
    var body: some View {
        List {
            // 'id' can be specified as either 'self' or a unique attribute such as 'cca3'
            ForEach(foundNutritionList, id: \.self) { aNutrition in
                NavigationLink(destination: SearchNutritionDetails(food: aNutrition)) {
                    FoodFavoriteItem(food: aNutrition)
                }
            }
        }
        .navigationTitle("Nutrition API Search Results")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    SearchNutritionList()
}
