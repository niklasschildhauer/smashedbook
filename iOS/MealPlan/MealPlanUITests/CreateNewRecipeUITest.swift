//
//  CreateNewRecipe.swift
//  MealPlanUITests
//
//  Created by Niklas Schildhauer on 28.08.23.
//

import XCTest

final class CreateNewRecipeUITest: XCTestCase {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    func testCreateBasicRecipe() throws {
        XCTAssertTrue(app.otherElements["recipeOverviewPageView"].exists)
        
        createNewRecipe()
        setNameOfRecipe(name: "Basisrezept")
        
        let listSections = getListSections()
        XCTAssertEqual(listSections.count, 3)

        let metaSection = listSections.firstMatch
        let energryInput = metaSection.otherElements["energyInput"]
        XCTAssertTrue(energryInput.exists)
        energryInput.textFields.firstMatch.tap()
        energryInput.textFields.firstMatch.typeText("400")
        XCTAssertEqual(energryInput.textFields.firstMatch.value as! String, "400")

        let mealInput = metaSection.otherElements["mealInput"]
        XCTAssertTrue(mealInput.exists)
        mealInput.tap()
        app.cells.element(boundBy: 1).tap()

        let ingredientContentSection = listSections.element(boundBy: 1)
        let ingredientSectionTitle = ingredientContentSection.staticTexts.matching(identifier: "ZUTATEN").firstMatch
        XCTAssertTrue(ingredientSectionTitle.exists)
        
        let ingredientPotionCounter = ingredientContentSection.otherElements["portionCounter"]
        XCTAssertTrue(ingredientSectionTitle.exists)
        XCTAssertEqual(ingredientPotionCounter.staticTexts.firstMatch.label, "2 Portionen")
        
        let decreaseButton = ingredientPotionCounter.buttons["decreasePortionButton"]
        decreaseButton.tap()
        XCTAssertEqual(ingredientPotionCounter.staticTexts.firstMatch.label, "1 Portion")
        XCTAssertFalse(decreaseButton.exists)
        
        let increaseButton = ingredientPotionCounter.buttons["increasePortionButton"]
        increaseButton.tap()
        XCTAssertTrue(decreaseButton.exists)
        increaseButton.tap()
        XCTAssertEqual(ingredientPotionCounter.staticTexts.firstMatch.label, "3 Portionen")

        
        let ingredientCells = ingredientContentSection.otherElements.matching(identifier: "listCell")
        XCTAssertEqual(ingredientCells.count, 0)
        
        let addIngredientButton = ingredientContentSection.buttons["Foto hinzufügen"].firstMatch
        XCTAssertTrue(addIngredientButton.exists)
        addIngredientButton.tap()
        app.otherElements["Photos"].scrollViews.otherElements.images["Photo, March 30, 2018, 9:14 PM"].tap()

        XCTAssertEqual(ingredientCells.count, 1)
    }
    
    private func createNewRecipe() {
        let addRecipeButton = app.buttons["addRecipeButton"]
        addRecipeButton.tap()
        XCTAssertTrue(app.otherElements["addRecipePageView"].exists)
    }
    
    private func setNameOfRecipe(name: String) {
        let recipeNameTextField = app.textFields["recipeNameInput"].firstMatch
        recipeNameTextField.tap()
        recipeNameTextField.typeText(name)
        XCTAssertEqual(recipeNameTextField.value as! String, name)
    }
    
    private func getListSections() -> XCUIElementQuery {
        return app.otherElements.matching(identifier: "listSection")
    }
    
}

