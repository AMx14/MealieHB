//
//  AddRecipeView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import SwiftUI
import SwiftData

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    @State private var name = ""
    @State private var category = ""
    @State private var selectedTags: Set<String> = []
    @State private var ingredients: [Ingredient] = [Ingredient(name: "", quantity: "")]
    @State private var steps: [String] = [""]

    let categories = ["Breakfast", "Lunch", "Dinner", "Snack", "Dessert"]
    let dietaryTags = ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Low-Carb"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Recipe Name", text: $name)
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                }

                Section(header: Text("Dietary Tags")) {
                    ForEach(dietaryTags, id: \.self) { tag in
                        Toggle(tag, isOn: Binding(
                            get: { selectedTags.contains(tag) },
                            set: { isSelected in
                                if isSelected {
                                    selectedTags.insert(tag)
                                } else {
                                    selectedTags.remove(tag)
                                }
                            }
                        ))
                    }
                }

                Section(header: Text("Ingredients")) {
                    ForEach($ingredients) { $ingredient in
                        HStack {
                            TextField("Quantity", text: $ingredient.quantity)
                                .frame(width: 100)
                            TextField("Ingredient", text: $ingredient.name)
                        }
                    }
                    Button("Add Ingredient") {
                        ingredients.append(Ingredient(name: "", quantity: ""))
                    }
                }

                Section(header: Text("Steps")) {
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, _ in
                        TextField("Step \(index + 1)", text: $steps[index])
                    }
                    Button("Add Step") {
                        steps.append("")
                    }
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(name.isEmpty || category.isEmpty || ingredients.isEmpty || steps.isEmpty)
                }
            }
        }
    }

    private func saveRecipe() {
        let filteredIngredients = ingredients.filter { !$0.name.isEmpty && !$0.quantity.isEmpty }
        let filteredSteps = steps.filter { !$0.isEmpty }

        let recipe = Recipe(
            name: name,
            ingredients: filteredIngredients,
            steps: filteredSteps,
            category: category,
            dietaryTags: Array(selectedTags)
        )

        recipeViewModel.saveRecipe(recipe)
        dismiss()
    }
}
