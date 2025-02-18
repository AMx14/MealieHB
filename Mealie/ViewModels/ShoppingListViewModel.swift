//
//  ShoppingListViewModel.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class ShoppingListViewModel: ObservableObject {
    private let dataStore: DataStoreProtocol
    @Published var currentShoppingList: ShoppingList?
    @Published var errorMessage: String?

    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }

    func generateShoppingList(for mealPlan: MealPlan) {
        Task {
            do {
                let shoppingList = try await dataStore.generateShoppingList(for: mealPlan)
                try await dataStore.saveShoppingList(shoppingList)
                currentShoppingList = shoppingList
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
