//
//  RecipeModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 19.08.23.
//

import Foundation

public struct RecipeModel: Codable, Hashable, Identifiable {
    public var id = UUID()
    var title: String = ""
    var titleImage: ImageResourceModel?
    var attachments: [ImageResourceModel] = []
    var ingredients = [RecipeIngredientModel(name: "Ingwer", value: "1/2", unit: .gram), RecipeIngredientModel(name: "Mehr", value: "500", unit: .gram)]
    var steps = [RecipeStepModel(description: "Test nummero uno"), .init(description: "Zeiter Eintrag")]
}

public var recipeModelMock: RecipeModel {
    .init(title: "Lachs mit Tomate")
}

