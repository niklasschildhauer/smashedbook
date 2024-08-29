//
//  RecipeDataSourcee.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.10.23.
//

import Foundation

@Observable class RecipesDataSource {
    var recipes = [recipeModelMock]
    
    func loadRecipes() {
        // todo
    }
    
    func save(recipe: RecipeModel) {
        saveLoacally(recipe: recipe)
        print(recipe.attachments)
    }
    
    private func saveLoacally(recipe: RecipeModel) {
        print("We will save")
        if let recipeIndex = recipes.firstIndex(where: { $0.id == recipe.id }) {
            print("We did save")

            recipes[recipeIndex] = recipe
        } else {
            print("We failed")

            recipes.append(recipe)
            print(recipes)
        }
    }
}
