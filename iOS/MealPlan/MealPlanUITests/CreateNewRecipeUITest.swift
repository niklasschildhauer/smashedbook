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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
    func testCreateBasicRecipe() throws {
        createNewRecipe()
        setNameOfRecipe(name: "Basisrezept")


        let listSections = app.otherElements.matching(identifier: "listSection")
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
        let ingredientCells = ingredientContentSection.otherElements.matching(identifier: "listCell")
        XCTAssertEqual(ingredientCells.count, 1)
        let addIngredientMenu = ingredientCells.buttons["Hinzufügen"]
        XCTAssertTrue(addIngredientMenu.exists)
        addIngredientMenu.tap()
    
        // Add image in another way then with menu.
        
    }
    
    private func createNewRecipe() {
        let addRecipeButton = app.buttons["addRecipeButton"]
        addRecipeButton.tap()
    }
    
    private func setNameOfRecipe(name: String) {
        let recipeNameTextField = app.textFields["recipeNameInput"].firstMatch
        recipeNameTextField.tap()
        recipeNameTextField.typeText(name)
        XCTAssertEqual(recipeNameTextField.value as! String, name)
    }
}

