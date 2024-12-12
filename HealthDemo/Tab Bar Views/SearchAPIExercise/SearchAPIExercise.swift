//
//  SearchAPIExercise.swift
//  Health
//
//  Created by Adam Hall, Daniel Losada and Osman Balci on 9/16/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI

struct SearchAPIExercise: View {
    
    let searchCategories = ["name", "type", "muscle", "difficulty"]
    @State private var selectedIndex = 0
    
    @State private var searchFieldValue = ""
    @State private var searchCompleted = false
    @State private var showAlertMessage = false
    
    private let typeSelction = ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"]
    @State private var selectedType = 0
    
    private let muscletypeSelction = ["abdominals", "abductors", "adductors", "biceps", "calves", "chest", "forearms", "glutes", "hamstrings", "lats", "lower_back", "middle_back", "neck", "quadriceps", "traps", "triceps"]
    @State private var selectedMuscle = 0
    
    private let difficultySelction = ["beginner", "intermediate", "expert"]
    @State private var selectedDiff = 0
    
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
                Section(header: Text("Select Search Category")) {
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< searchCategories.count, id: \.self) {
                            Text(searchCategories[$0])
                        }
                    }
                }
                Section(header: Text("Enter a \(searchCategories[selectedIndex])")) {
                    if selectedIndex == 0 {
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
                    else if selectedIndex == 1 {
                        Picker("", selection: $selectedType) {
                            ForEach(0 ..< typeSelction.count, id: \.self) {
                                Text(typeSelction[$0])
                            }
                        }
                    }
                    else if selectedIndex == 2 {
                        Picker("", selection: $selectedMuscle) {
                            ForEach(0 ..< muscletypeSelction.count, id: \.self) {
                                Text(muscletypeSelction[$0])
                            }
                        }
                    }
                    else if selectedIndex == 3 {
                        Picker("", selection: $selectedDiff) {
                            ForEach(0 ..< difficultySelction.count, id: \.self) {
                                Text(difficultySelction[$0])
                            }
                        }
                    }
                }
                
                Section(header: Text("Search Exercises")) {
                    HStack {
                        Spacer()
                        Button(searchCompleted ? "Search Completed" : "Search") {
                            if inputDataValidated() {
                                searchApi()
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
                    Section(header: Text("List Exercises Found")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                Text("List Exercises Found")
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
                
            }   // End of Form
            .navigationTitle("Search Exercise")
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
    func searchApi() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*
         Since URLs cannot have spaces, replace space in query with
         Unicode Transformation Format 8-bit (UTF-8) encoding of space as %20
         Example: South Africa --> South%20Africa
         NOTE: This API uses %20 for space; other APIs may use + instead.
         */
        //let queryCleaned = queryTrimmed.replacingOccurrences(of: " ", with: "%20")
        
        // Convert the query to lowercase
        //let searchQuery = queryCleaned.lowercased()
        
        // Public function getFoundExercisesFromApi is given in ExerciseApiData.swift
        if selectedIndex == 0 {
            getFoundExercisesFromApi(category: searchCategories[selectedIndex], query: queryTrimmed)
        }
        else if selectedIndex == 1 {
            getFoundExercisesFromApi(category: searchCategories[selectedIndex], query: typeSelction[selectedType])
        }
        else if selectedIndex == 2 {
            getFoundExercisesFromApi(category: searchCategories[selectedIndex], query: muscletypeSelction[selectedMuscle])
        }
        else if selectedIndex == 3 {
            getFoundExercisesFromApi(category: searchCategories[selectedIndex], query: difficultySelction[selectedDiff])
        }
    }
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchResults: some View {
        
        // Global array foundExercisesList is given in CountryApiData.swift
        if foundExercisesList.isEmpty {
            return AnyView(
                NotFound(message: "No Exercises Found!\n\nThe entered query \(searchFieldValue) did not return any exercise from the API! Please enter another search query.")
            )
        }
        
        return AnyView(SearchExercisesList())
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if selectedIndex == 0 {
            if queryTrimmed.isEmpty {
                return false
            }
        }
        return true
    }
    
}


#Preview {
    SearchAPIExercise()
}
