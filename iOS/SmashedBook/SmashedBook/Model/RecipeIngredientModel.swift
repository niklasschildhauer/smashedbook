//
//  RecipeIngredientModel.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import Foundation

enum RecipeIngredientUnit: String, CaseIterable, Codable {
    case kilogram = "Kilogramm"
    case gram = "Gramm"
    case litre = "Liter"
    case millilitre = "Milliliter"
}

struct RecipeIngredientModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
    var unit: RecipeIngredientUnit
}
