//
//  LoadingResult.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation

struct RecipeStepModel: Codable, Hashable, Identifiable {
    var id = UUID()
    var description: String
}
