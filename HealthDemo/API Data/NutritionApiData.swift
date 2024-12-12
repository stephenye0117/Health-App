//
//  NutritionApiData.swift
//  Health
//
//  Created by Osman Balci and Adam Hall on 11/30/24.
//  Copyright © 2024 Adam Hall. All rights reserved.
//

import Foundation

var foundNutritionList = [Nutrition]()

public func getFoundNutritionFromApi(query: String) {
    // Initialize the global variable to contain the API search results
    foundNutritionList = [Nutrition]()
    
    
    let apiUrlString = "https://api.api-ninjas.com/v1/nutrition?query=\(query)"
    
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
            
            // calories
            var caloriesNumber = 0.0
            if let a = nutritionDataDictionary["calories"] as? Double {
                caloriesNumber = a
            }
            
            // serving_size_g
            var serving_size_gNumber = 0.0
            if let a = nutritionDataDictionary["serving_size_g"] as? Double {
                serving_size_gNumber = a
            }
            
            // fat_total_g
            var fat_total_gNumber = 0.0
            if let a = nutritionDataDictionary["serving_size_g"] as? Double {
                fat_total_gNumber = a
            }
            
            // fat_saturated_g
            var fat_saturated_gNumber = 0.0
            if let a = nutritionDataDictionary["fat_saturated_g"] as? Double {
                fat_saturated_gNumber = a
            }
            
            // protein_g
            var protein_gNumber = 0.0
            if let a = nutritionDataDictionary["protein_g"] as? Double {
                protein_gNumber = a
            }
            
            // sodium_mg
            var sodium_mgNumber = 0.0
            if let a = nutritionDataDictionary["sodium_mg"] as? Double {
                sodium_mgNumber = a
            }
            
            // potassium_mg
            var potassium_mgNumber = 0.0
            if let a = nutritionDataDictionary["potassium_mg"] as? Double {
                potassium_mgNumber = a
            }
            
            // cholesterol_mg
            var cholesterol_mgNumber = 0.0
            if let a = nutritionDataDictionary["cholesterol_mg"] as? Double {
                cholesterol_mgNumber = a
            }
            
            // carbohydrates_total_g
            var carbohydrates_total_gNumber = 0.0
            if let a = nutritionDataDictionary["carbohydrates_total_g"] as? Double {
                carbohydrates_total_gNumber = a
            }
            
            // fiber_g
            var fiber_gNumber = 0.0
            if let a = nutritionDataDictionary["fiber_g"] as? Double {
                fiber_gNumber = a
            }
            
            // sugar_g
            var sugar_gNumber = 0.0
            if let a = nutritionDataDictionary["sugar_g"] as? Double {
                sugar_gNumber = a
            }
            
            let nutritionFound = Nutrition(name: nameStr, calories: caloriesNumber, serving_size_g: serving_size_gNumber, fat_total_g: fat_total_gNumber, fat_saturated_g: fat_saturated_gNumber, protein_g: protein_gNumber, sodium_mg: sodium_mgNumber, potassium_mg: potassium_mgNumber, cholesterol_mg: cholesterol_mgNumber, carbohydrates_total_g: carbohydrates_total_gNumber, fiber_g: fiber_gNumber, sugar_g: sugar_gNumber)
            
            foundNutritionList.append(nutritionFound)
        }
        foundNutritionList = foundNutritionList.sorted{ $0.name < $1.name }
        
    } catch {
        return
    }
}
