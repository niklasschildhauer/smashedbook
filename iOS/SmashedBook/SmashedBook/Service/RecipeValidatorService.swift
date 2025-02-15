//
//  RecipeValidatorService.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 15.02.25.
//

class RecipeValidatorService {
    func isRecipeValid(_ recipe: RecipeModel) -> Bool {
        if recipe.title == "" {
            return false
        }
        
        return true
    }
}
