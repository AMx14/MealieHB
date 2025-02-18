//
//  DataStoreProtocol.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import SwiftUI
import SwiftData

// MARK: - Protocol
protocol DataStoreProtocol {
    // Recipe Operations
    func saveRecipe(_ recipe: Recipe) async throws
    func fetchRecipes() async throws -> [Recipe]
    func updateRecipe(_ recipe: Recipe) async throws
    func deleteRecipe(_ recipe: Recipe) async throws
    func searchRecipes(query: String, category: String?, dietaryTags: [String]?) async throws -> [Recipe]
    
    // MealPlan Operations
    func saveMealPlan(_ mealPlan: MealPlan) async throws
    func fetchMealPlans(for date: Date) async throws -> [MealPlan]
    func updateMealPlan(_ mealPlan: MealPlan) async throws
    func deleteMealPlan(_ mealPlan: MealPlan) async throws
    
    // Shopping List Operations
    func generateShoppingList(for mealPlan: MealPlan) async throws -> ShoppingList
    func saveShoppingList(_ shoppingList: ShoppingList) async throws
}
