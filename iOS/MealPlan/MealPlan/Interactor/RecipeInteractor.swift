//
//  RecipeInteractor.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import Foundation

protocol RecipeInteractoring {
    func loadRecipies() async -> [Recipe]
}

class RecipeInteractor: RecipeInteractoring {
    func loadRecipies() async -> [Recipe] {
        sleep(1)
        
        guard let fileURL = Bundle.main.url(forResource: "RecipeMock", withExtension: "json") else {
            print("JSON file not found.")
            return []
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodeRecipies = try decoder.decode([Recipe].self, from: jsonData)
            return decodeRecipies
        } catch {
            print("Error reading or decoding JSON file: \(error)")
            return []
        }
    }
}

