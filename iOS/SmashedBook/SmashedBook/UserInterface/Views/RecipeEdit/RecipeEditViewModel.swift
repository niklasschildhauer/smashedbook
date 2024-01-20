//
//  RecipeEditViewModel.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 20.01.24.
//

import SwiftUI

@Observable
class RecipeEditViewModel {
    var recipeModel: RecipeModel {
        didSet {
            isRecipeEdited = true
        }
    }
    var validateErrorMessage: String?
    var isRecipeEdited = false
    
    init(recipeModel: RecipeModel) {
        self._recipeModel = recipeModel
    }
        
    func isRecipeValid() -> Bool {
        return true
    }
}
