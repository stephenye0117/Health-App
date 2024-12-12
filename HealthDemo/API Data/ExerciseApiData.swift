//
//  ExerciseApiData.swift
//  Health
//
//  Created by Osman Balci and Adam Hall on 11/30/24.
//  Copyright © 2024 Adam Hall. All rights reserved.
//

import Foundation

var foundExercisesList = [Exercise]()

public func getFoundExercisesFromApi(category: String, query: String) {
    // Initialize the global variable to contain the API search results
    foundExercisesList = [Exercise]()
    
    
    var apiUrlString = ""
    
    switch category {
    case "name":
        apiUrlString = "https://api.api-ninjas.com/v1/exercises?name=\(query)"
    case "type":
        apiUrlString = "https://api.api-ninjas.com/v1/exercises?type=\(query)"
    case "muscle":
        apiUrlString = "https://api.api-ninjas.com/v1/exercises?muscle=\(query)"
    case "difficulty":
        apiUrlString = "https://api.api-ninjas.com/v1/exercises?difficulty=\(query)"
    default:
        print("invalid catagory")
    }
    
    /*
     ***************************************************
     *   Fetch JSON Data from the API Asynchronously   *
     ***************************************************
     */
    var jsonDataFromApi: Data
    
    let jsonDataFetchedFromApi = getJsonDataFromApi(apiHeaders: ninjasApiHeaders, apiUrl: apiUrlString, timeout: 10.0)
    
    if let jsonData = jsonDataFetchedFromApi {
        jsonDataFromApi = jsonData
    } else {
        return
    }
    
    /*
     **************************************************
     *   Process the JSON Data Fetched from the API   *
     **************************************************
     */
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        //----------------------------
        // Obtain Top Level JSON Array
        //----------------------------
        var searchResultsJsonArray = [Any]()
        
        if let jsonArray = jsonResponse as? [Any] {
            searchResultsJsonArray = jsonArray
        } else {
            return
        }
        
        for jsonObject in searchResultsJsonArray {
            // Make sure that the array item is indeed a JSON object (Swift dictionary type)
            var nutritionDataDictionary = [String: Any]()
            
            if let jObject = jsonObject as? [String: Any] {
                nutritionDataDictionary = jObject
            } else {
                continue
            }
            
            // Name
            var nameStr = ""
            if let a = nutritionDataDictionary["name"] as? String {
                nameStr = a
            }
            
            // type
            var typeStr = ""
            if let a = nutritionDataDictionary["type"] as? String {
                typeStr = a
            }
            
            // muscle
            var muscleStr = ""
            if let a = nutritionDataDictionary["muscle"] as? String {
                muscleStr = a
            }
            
            // equipment
            var equipmentStr = ""
            if let a = nutritionDataDictionary["equipment"] as? String {
                equipmentStr = a
            }
            
            // difficulty
            var difficultyStr = ""
            if let a = nutritionDataDictionary["difficulty"] as? String {
                difficultyStr = a
            }
            
            // instructions
            var instructionsStr = ""
            if let a = nutritionDataDictionary["instructions"] as? String {
                instructionsStr = a
            }
            
            let exerciseFound = Exercise(name: nameStr, type: typeStr, muscle: muscleStr, equipment: equipmentStr, difficulty: difficultyStr, instructions: instructionsStr)
            
            foundExercisesList.append(exerciseFound)
        }
        foundExercisesList = foundExercisesList.sorted{ $0.name < $1.name }
        
    } catch {
        return
    }
}
