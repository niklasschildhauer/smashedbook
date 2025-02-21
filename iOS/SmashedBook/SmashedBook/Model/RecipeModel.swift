//
//  RecipeModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 19.08.23.
//

import Foundation

public struct RecipeModel: Codable, Hashable, Identifiable {
    public var id = UUID()
    var generalInformation: RecipeGeneralInformationModel = .init()
    var attachments: [ImageResourceModel] = []
    var ingredients: [RecipeIngredientModel] = []
    var steps: [RecipeStepModel] = []
}

public var recipeModelMock: RecipeModel {
    var recipe = RecipeModel()
    recipe.generalInformation.energy = 300
    recipe.generalInformation.duration = 30
    recipe.generalInformation.meal = .lunch
    
    return recipe
}

