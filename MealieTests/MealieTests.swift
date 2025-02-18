//
//  MealieTests.swift
//  MealieTests
//
//  Created by Akshat Maithani on 18/02/25.
//

import XCTest
@testable import Mealie

final class MealieTests: XCTestCase {
    var modelContainer: ModelContainer!
    var dataStore: SwiftDataStore!
    
    override func setUpWithError() throws {
        let schema = Schema([Recipe.self, Ingredient.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        dataStore = SwiftDataStore(modelContext: modelContainer.mainContext)
    }
    
    override func tearDownWithError() throws {
        modelContainer = nil
        dataStore = nil
    }
    
    func testRecipeCreation() async throws {
        // Given
        let ingredient = Ingredient(name: "Test Ingredient", quantity: "1 cup")
        let recipe = Recipe(
            name: "Test Recipe",
            ingredients: [ingredient],
            steps: ["Step 1"],
            category: "Test",
            dietaryTags: ["Vegetarian"]
        )
        
        // When
        try await dataStore.saveRecipe(recipe)
        let recipes = try await dataStore.fetchRecipes()
        
        // Then
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.name, "Test Recipe")
    }
    
    func testInputValidation() {
        // Test empty name
        let emptyNameRecipe = Recipe(
            name: "",
            ingredients: [],
            steps: ["Step 1"],
            category: "Test",
            dietaryTags: []
        )
        
        XCTAssertThrowsError(try InputValidator.validateRecipe(emptyNameRecipe)) { error in
            XCTAssertEqual((error as? ValidationError)?.errorDescription, "Name cannot be empty")
        }
    }
}
