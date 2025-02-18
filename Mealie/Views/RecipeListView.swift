//
//  RecipeListView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import SwiftUI
import SwiftData

struct RecipeListView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showingAddRecipe = false
    @State private var searchText = ""
    @State private var selectedCategory: String?
    @State private var selectedDietaryTags: Set<String> = []
    @State private var isLoading = true
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty && selectedCategory == nil && selectedDietaryTags.isEmpty {
            return recipeViewModel.recipes
        }
        return recipeViewModel.recipes.filter { recipe in
            let matchesSearch = searchText.isEmpty ||
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            
            let matchesCategory = selectedCategory == nil || recipe.category == selectedCategory
            
            let matchesTags = selectedDietaryTags.isEmpty ||
                selectedDietaryTags.isSubset(of: Set(recipe.dietaryTags))
            
            return matchesSearch && matchesCategory && matchesTags
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView()
                } else if recipeViewModel.recipes.isEmpty {
                    ContentUnavailableView(
                        "No Recipes",
                        systemImage: "book",
                        description: Text("Add your first recipe to get started")
                    )
                } else {
                    List {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRowView(recipe: recipe)
                            }
                        }
                        .onDelete(perform: deleteRecipes)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search recipes")
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddRecipe = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView()
            }
        }
        .task {
            await loadRecipes()
        }
    }
    
    private func loadRecipes() async {
        isLoading = true
        recipeViewModel.fetchRecipes()
        isLoading = false
    }
    
    private func deleteRecipes(at offsets: IndexSet) {
        offsets.forEach { index in
            let recipe = filteredRecipes[index]
            recipeViewModel.deleteRecipe(recipe)
        }
    }
}

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.headline)
            HStack {
                Text(recipe.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                ForEach(recipe.dietaryTags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
