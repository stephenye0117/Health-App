//
//  FavoritesFoodList.swift
//  Health
//
//  Created by Stephen Ye and Osman Balci on 12/3/24.
//


import SwiftUI
import SwiftData

struct FoodFavoritesList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Nutrition>(sortBy: [SortDescriptor(\Nutrition.name, order: .forward)])) private var listOfAllFoodsInDatabase: [Nutrition]
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredFoods) { aFood in
                    NavigationLink(destination: FoodFavoriteDetails(food: aFood)) {
                        FoodFavoriteItem(food: aFood)
                            .alert(isPresented: $showConfirmation) {
                                Alert(title: Text("Delete Confirmation"),
                                      message: Text("Are you sure to permanently delete this food?"),
                                      primaryButton: .destructive(Text("Delete")) {
                                            if let index = toBeDeleted?.first {
                                                let foodToDelete = listOfAllFoodsInDatabase[index]
                                                modelContext.delete(foodToDelete)
                                            }
                                            toBeDeleted = nil
                                      }, secondaryButton: .cancel() {
                                            toBeDeleted = nil
                                      }
                                )
                            }
                    }
                }
                .onDelete(perform: delete)
            }
            .font(.system(size: 14))
            .navigationTitle("Favorite Foods")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search Favorite Foods")
    }
    
    var filteredFoods: [Nutrition] {
        if searchText.isEmpty {
            listOfAllFoodsInDatabase
        } else {
            listOfAllFoodsInDatabase.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        toBeDeleted = offsets
        showConfirmation = true
    }
}
