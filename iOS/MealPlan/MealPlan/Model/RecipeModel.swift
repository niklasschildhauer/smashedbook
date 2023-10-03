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
    var metaInformation = [RecipeMetaInformationModel]()
    var ingredients = [RecipeContentModel]()
    var steps = [RecipeContentModel]()
}

public var recipeModelMock: RecipeModel {
    .init(title: "Mockrezept",
          metaInformation: [
            .init(key: "Mahlzeit", value: "Mittagessen"),
            .init(key: "Energie", value: "500")
          ])
}
