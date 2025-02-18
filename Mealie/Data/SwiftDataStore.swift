//
//  SwiftDataStore.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

// Data/SwiftDataStore.swift
import SwiftUI
import SwiftData
import Foundation

@MainActor
class SwiftDataStore: DataStoreProtocol {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Recipe Operations
    func saveRecipe(_ recipe: Recipe) async throws {
        // Check for duplicates
        let existingRecipes = try await fetchRecipes()
        guard !existingRecipes.contains(where: {
            $0.name.lowercased() == recipe.name.lowercased() &&
            $0.ingredients.count == recipe.ingredients.count &&
            Set($0.ingredients.map { $0.name.lowercased() }) ==
            Set(recipe.ingredients.map { $0.name.lowercased() })
        }) else {
            throw StoreError.duplicateRecipe
        }
        
        modelContext.insert(recipe)
        try modelContext.save()
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func updateRecipe(_ recipe: Recipe) async throws {
        try modelContext.save()
    }
    
    func deleteRecipe(_ recipe: Recipe) async throws {
        modelContext.delete(recipe)
        try modelContext.save()
    }
    
    func searchRecipes(query: String, category: String? = nil, dietaryTags: [String]? = nil) async throws -> [Recipe] {
        var predicates: [Predicate<Recipe>] = []
        
        if !query.isEmpty {
            predicates.append(#Predicate<Recipe> { recipe in
                recipe.name.localizedStandardContains(query) ||
                recipe.ingredients.contains(where: { $0.name.localizedStandardContains(query) })
            })
        }
        
        if let category = category {
            predicates.append(#Predicate<Recipe> { recipe in
                recipe.category == category
            })
        }
        
        if let dietaryTags = dietaryTags, !dietaryTags.isEmpty {
            predicates.append(#Predicate<Recipe> { recipe in
                dietaryTags.allSatisfy { tag in
                    recipe.dietaryTags.contains(tag)
                }
            })
        }
        
        let combinedPredicate: Predicate<Recipe>? = {
            guard !predicates.isEmpty else { return nil }
            
            if predicates.count == 1 {
                return predicates[0]
            }
            
            return #Predicate<Recipe> { recipe in
                predicates.allSatisfy { predicate in
                    predicate.evaluate(recipe)
                }
            }
        }()
        
        let descriptor = FetchDescriptor<Recipe>(
            predicate: combinedPredicate,
            sortBy: [SortDescriptor(\.name)]
        )
        
        return try modelContext.fetch(descriptor)
    }
    
    // MARK: - MealPlan Operations
    func saveMealPlan(_ mealPlan: MealPlan) async throws {
        modelContext.insert(mealPlan)
        try modelContext.save()
    }
    
    func fetchMealPlans(for date: Date) async throws -> [MealPlan] {
        let calendar = Calendar.current
        let startOfWeek = calendar.startOfDay(for: date) // Normalize to midnight
        let descriptor = FetchDescriptor<MealPlan>(
            predicate: #Predicate { $0.weekStartDate == startOfWeek },
            sortBy: [SortDescriptor(\.weekStartDate, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }

    func updateMealPlan(_ mealPlan: MealPlan) async throws {
        try modelContext.save()
    }
    
    func deleteMealPlan(_ mealPlan: MealPlan) async throws {
        modelContext.delete(mealPlan)
        try modelContext.save()
    }
    
    // MARK: - Shopping List Operations
    func generateShoppingList(for mealPlan: MealPlan) async throws -> ShoppingList {
        var combinedIngredients: [String: String] = [:]
        
        for meal in mealPlan.meals {
            guard let recipe = meal.recipe else { continue }
            
            for ingredient in recipe.ingredients {
                combinedIngredients[ingredient.name] = ingredient.quantity
            }
        }
        
        let shoppingListIngredients = combinedIngredients.map { name, quantity in
            Ingredient(name: name, quantity: quantity)
        }
        
        return ShoppingList(ingredients: shoppingListIngredients)
    }
    
    func saveShoppingList(_ shoppingList: ShoppingList) async throws {
        modelContext.insert(shoppingList)
        try modelContext.save()
    }
}

// MARK: - Custom Errors
enum StoreError: LocalizedError {
    case duplicateRecipe
    case invalidRecipe
    case invalidMealPlan
    case saveFailed
    
    var errorDescription: String? {
        switch self {
        case .duplicateRecipe:
            return "A recipe with the same name and ingredients already exists"
        case .invalidRecipe:
            return "The recipe data is invalid"
        case .invalidMealPlan:
            return "The meal plan data is invalid"
        case .saveFailed:
            return "Failed to save data"
        }
    }
}
