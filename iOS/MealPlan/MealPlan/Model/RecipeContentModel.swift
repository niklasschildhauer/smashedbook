//
//  RecipeDetailModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation

public struct RecipeContentModel: Codable, Hashable {
    var id = UUID()
    var type: ContentType
    
    public enum ContentType: Codable, Hashable {
        case image(imageUrl: URL)
        case description(descriptionText: String)
        case ingredient(value: String, unit: IngredientUnit)
    }

    public enum IngredientUnit: String, Codable, Hashable {
        case gram
        case kiloGram
    }
}


