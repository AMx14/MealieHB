//
//  ShoppingListView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @EnvironmentObject var shoppingListViewModel: ShoppingListViewModel
    @EnvironmentObject var mealPlannerViewModel: MealPlannerViewModel

    var body: some View {
        NavigationView {
            List {
                if let shoppingList = shoppingListViewModel.currentShoppingList {
                    ForEach(shoppingList.ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text(ingredient.quantity)
                                .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text("No shopping list generated")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                Button("Generate") {
                    if let currentMealPlan = mealPlannerViewModel.mealPlans.first {
                        shoppingListViewModel.generateShoppingList(for: currentMealPlan)
                    }
                }
            }
        }
    }
}
