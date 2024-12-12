//
//  SearchAPINutrition.swift
//  Health
//
//  Created by Adam Hall and Osman Balci on 9/16/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI

struct SearchAPINutrition: View {
        
    @State private var searchFieldValue = ""
    @State private var searchCompleted = false
    @State private var showAlertMessage = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        Image("SearchAPI")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                        Spacer()
                    }
                }
                Section(header: Text("Enter a Food Name")) {
                    HStack {
                        TextField("Enter Search Query", text: $searchFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        
                        // Button to clear the text field
                        Button(action: {
                            searchFieldValue = ""
                            showAlertMessage = false
                            searchCompleted = false
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                                .foregroundColor(.blue)
                        }
                        
                    }   // End of HStack
                }
                
                Section(header: Text("Search Food")) {
                    HStack {
                        Spacer()
                        Button(searchCompleted ? "Search Completed" : "Search") {
                            if inputDataValidated() {
                                searchApiNutrition()
                                searchCompleted = true
                            } else {
                                showAlertMessage = true
                                alertTitle = "Missing Input Data!"
                                alertMessage = "Please enter a search query!"
                            }
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                        Spacer()
                    }   // End of HStack
                }
                
                if searchCompleted {
                    Section(header: Text("List Food Found")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                Text("List Food Found")
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                
            }   // End of Form
            .navigationTitle("Search Food")
            .toolbarTitleDisplayMode(.inline)
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            })
            
        }   // End of NavigationStack
        
    }   // End of body var
    
    /*
     ----------------
     MARK: Search API
     ----------------
     */
    func searchApiNutrition() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*
         Since URLs cannot have spaces, replace space in query with
         Unicode Transformation Format 8-bit (UTF-8) encoding of space as %20
         Example: South Africa --> South%20Africa
         NOTE: This API uses %20 for space; other APIs may use + instead.
         */
        let queryCleaned = queryTrimmed.replacingOccurrences(of: " ", with: "%20")
        
        // Convert the query to lowercase
        let searchQuery = queryCleaned.lowercased()
        
        // Public function getFoundExercisesFromApi is given in ExerciseApiData.swift
        getFoundNutritionFromApi(query: searchQuery)
    }
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchResults: some View {
        
        // Global array foundExercisesList is given in CountryApiData.swift
        if foundNutritionList.isEmpty {
            return AnyView(
                NotFound(message: "No food Found!\n\nThe entered query \(searchFieldValue) did not return any food from the API! Please enter another search query.")
            )
        }
        
        return AnyView(SearchNutritionList())
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
    
}


#Preview {
    SearchAPINutrition()
}
