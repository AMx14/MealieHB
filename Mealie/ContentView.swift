//
//  ContentView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }

            MealPlannerView()
                .tabItem {
                    Label("Meal Plan", systemImage: "calendar")
                }

            ShoppingListView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }
        }
    }
}
