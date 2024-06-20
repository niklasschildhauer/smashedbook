//
//  RecipeDetailModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation
import SwiftUI

public struct RecipeContentModel: Codable, Hashable {
    var id = UUID()
    var type: ContentType
    
    enum ContentType: Codable, Hashable {
        case step(RecipeStepModel)
        case ingredient(RecipeIngredientModel)
    }
}

