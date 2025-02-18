//
//  RecipeViewModel.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class RecipeViewModel: ObservableObject {
    private let dataStore: DataStoreProtocol
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }

    func fetchRecipes() {
        Task {
            do {
                recipes = try await dataStore.fetchRecipes()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func saveRecipe(_ recipe: Recipe) {
        Task {
            do {
                try await dataStore.saveRecipe(recipe)
                await fetchRecipes()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func deleteRecipe(_ recipe: Recipe) {
        Task {
            do {
                try await dataStore.deleteRecipe(recipe)
                await fetchRecipes()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func searchRecipes(query: String, category: String? = nil, dietaryTags: [String]? = nil) {
        Task {
            do {
                recipes = try await dataStore.searchRecipes(query: query, category: category, dietaryTags: dietaryTags)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
