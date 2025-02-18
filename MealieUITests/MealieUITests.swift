//
//  MealieUITests.swift
//  MealieUITests
//
//  Created by Akshat Maithani on 18/02/25.
//

import XCTest

final class MealieUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAddRecipeFlow() throws {
        // Test adding a new recipe
        app.tabBars["Recipes"].tap()
        app.buttons["plus"].tap()
        
        // Fill in recipe details
        let nameTextField = app.textFields["Recipe Name"]
        nameTextField.tap()
        nameTextField.typeText("Test Recipe")
        
        // Add more UI test steps as needed
        
        // Verify recipe was added
        XCTAssertTrue(app.staticTexts["Test Recipe"].exists)
    }
    
    func testRecipeSearch() throws {
        // Test recipe search functionality
        app.tabBars["Recipes"].tap()
        
        let searchField = app.searchFields["Search recipes"]
        searchField.tap()
        searchField.typeText("Test")
        
        // Verify search results
        XCTAssertTrue(app.cells.count > 0)
    }
}
