//
//  RecipeInteractor.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import Foundation
import Combine

protocol RecipeInteractoring {
    func loadRecipes() async -> [RecipeModel]
//    func test() -> AnyPublisher<[RecipeModel], aError>
}

class RecipeInteractor: RecipeInteractoring {
//    func test() -> AnyPublisher<[RecipeModel], Error> {
//        return .Failure
//    }
    
    func loadRecipes() async -> [RecipeModel] {
        sleep(1)
        
        return [recipeModelMock]
    }
    
}

