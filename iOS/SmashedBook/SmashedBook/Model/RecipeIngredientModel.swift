//
//  RecipeIngredientModel.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import Foundation

enum RecipeIngredientUnit: String, CaseIterable, Codable {
    case kilogram = "kg"
    case litre = "l"
    case piece = "Stück"
    case tableSpoon = "EL"
    case teaSpoon = "TL"
    case prize = "Prise"
}

struct RecipeIngredientModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
    var unit: RecipeIngredientUnit
}
