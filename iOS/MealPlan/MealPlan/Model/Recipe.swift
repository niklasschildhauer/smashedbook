//
//  RecipeModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 19.08.23.
//

import Foundation

public struct Recipe: Codable, Hashable {
    var id = UUID()
    var title: String = ""
    var metaInformation = [RecipeMetaInformation]()
    var ingredients = [RecipeContent]()
    var steps = [RecipeContent]()
}

public struct RecipeMetaInformation: Codable, Hashable {
    var key: String
    var value: String
}

public struct RecipeContent: Codable, Hashable {
    var id = UUID()
    var type: RecipeContentType
}

public enum RecipeContentType: Codable, Hashable {
    case image(imageUrl: URL)
    case description(descriptionText: String)
}

public var recipeModelMock: Recipe {
    .init(title: "Mockrezept",
          metaInformation: [
            .init(key: "Mahlzeit", value: "Mittagessen"),
            .init(key: "Energie", value: "500")
          ],
          ingredients: [
            RecipeContent(type:
                    .image(imageUrl: URL(string: "www.test-image.de")!)
            )
          ],
          steps: [
            RecipeContent(type:
                    .image(imageUrl: URL(string: "www.test-image.de")!)
            )
          ])
}
