//
//  WebRepository.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation
import Combine

class RecipeWebRepository: RecipeRepository {
    func loadRecipes() -> AnyPublisher<[RecipeModel], Error> {
        let url = URL(string: "http://localhost:3000/recipes")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [RecipeModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadRecipeDetail(recipe: RecipeModel) -> AnyPublisher<RecipeModel, Error> {
        let url = URL(string: "http://localhost:3000/recipe/test/detail")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RecipeModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateRecipe(recipe: RecipeModel) -> AnyPublisher<RecipeModel, Error> {
        let baseURL = "http://localhost:3000/recipes"
        let url = URL(string: "\(baseURL)/\(recipe.id)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            request.httpBody = try jsonEncoder.encode(recipe)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RecipeModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Ensure UI updates are on the main thread
            .eraseToAnyPublisher()
    }
}
