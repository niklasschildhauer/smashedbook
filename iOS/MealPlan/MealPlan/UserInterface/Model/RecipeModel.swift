//
//  RecipeModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 19.08.23.
//

import Foundation

struct RecipeModel: Codable {
    var title: String
    var metaInformation: [RecipeMetaInformationModel]
    var ingredients: [RecipeContentModel]
    var steps: [RecipeContentModel]
}

struct RecipeMetaInformationModel: Codable {
    var key: String
    var value: String
}

struct RecipeContentModel: Codable {
    var order: Int
    var type: RecipeStepTypeEnum
}

enum RecipeStepTypeEnum: Codable {
    case picture(RecipeStepContentModel)
}

struct RecipeStepContentModel: Codable {
    let imageUrl: URL
}

