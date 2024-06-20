//
//  RecipeModel+RecipeValidator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 20.06.24.
//

import Foundation

class RecipeValidator {
    static func isRecipeValid(recipeModel: RecipeModel) -> Bool {
        return true
    }
}

extension RecipeModel {
    var isValid: Bool {
        RecipeValidator.isRecipeValid(recipeModel: self)
    }
}
