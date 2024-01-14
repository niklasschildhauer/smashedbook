//
//  RecipeIngredientModel.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import Foundation

struct RecipeIngredientModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var value: String
    var unit: String
}
