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
    var metaInformation = RecipeMetainformationModel()
    var attachments = [RecipeAttachmentModel(fileName: "deleteme")]
}

public var recipeModelMock: RecipeModel {
    .init(title: "Mockrezept",
          metaInformation: RecipeMetainformationModel())
}

