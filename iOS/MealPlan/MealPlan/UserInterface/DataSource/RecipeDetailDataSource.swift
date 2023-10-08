//
//  RecipeDetailDataSource.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 08.10.23.
//

import Foundation

@Observable class RecipeDetailDataSource {
    var recipe: RecipeModel
    
    private var recipesDataSource: RecipesDataSource
    
    init(recipe: RecipeModel, recipesDataSource: RecipesDataSource) {
        self.recipe = recipe
        self.recipesDataSource = recipesDataSource
    }
    
    func save(recipe: RecipeModel) {
        saveLoacally(recipe: recipe)
    }
    
    private func saveLoacally(recipe: RecipeModel) {
        print("We will save")
        if let recipeIndex = recipesDataSource.recipes.firstIndex(where: { $0.id == recipe.id }) {
            print("We did save")

            recipesDataSource.recipes[recipeIndex] = recipe
        } else {
            print("We failed")

            recipesDataSource.recipes.append(recipe)
        }
    }
}
