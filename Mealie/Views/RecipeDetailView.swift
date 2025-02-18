//
//  RecipeDetailView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name)
                    .font(.title)
                    .bold()

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

                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)

                    ForEach(recipe.ingredients) { ingredient in
                        Text("• \(ingredient.quantity) \(ingredient.name)")
                    }
                }
                .padding(.vertical)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.headline)

                    ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                        Text("\(index + 1). \(step)")
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
