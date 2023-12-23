//
//  RecipeInteractorUnitTest.swift
//  MealPlanTests
//
//  Created by Niklas Schildhauer on 10.09.23.
//

import XCTest
@testable import MealPlan

final class RecipeInteractorUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadRecipes() async throws {
        let recipeInteractor = RecipeInteractor()
        let result = await recipeInteractor.loadRecipes()
        XCTAssertEqual(result.count, 4)
    }

}

