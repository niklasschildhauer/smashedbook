//
//  RecipeRepositoryUnitTests.swift
//  MealPlanTests
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import XCTest
@testable import MealPlan
import Mockingbird

final class RecipeRepositoryUnitTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadRecipes() async throws {
        let webRepository = RecipeWebRepository()
        let expectation = XCTestExpectation(description: "Recipes are loaded")
        _ = webRepository.loadRecipes()
            .sink { _ in
            } receiveValue: { recipes in
                XCTAssertEqual(recipes.count, 4)
                expectation.fulfill()
                
            }
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testLoadRecipeDetail() async throws {
        let webRepository = RecipeWebRepository()
        let expectation = XCTestExpectation(description: "Recipe details are loaded")
        _ = webRepository.loadRecipeDetail(recipe: RecipeModel())
            .sink { _ in
            } receiveValue: { recipeDetail in
                XCTAssertEqual(recipeDetail.ingredients.count, 1)
                XCTAssertEqual(recipeDetail.steps.count, 1)
                expectation.fulfill()
            }
        await fulfillment(of: [expectation], timeout: 5)
    }
}
