//
//  RecipeRepository+protocol.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation
import Combine

protocol RecipeRepository {
    func loadRecipes() -> AnyPublisher<[RecipeModel], Error>
}
