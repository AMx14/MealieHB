//
//  Recipe.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import Foundation
import SwiftData

@Model
final class Recipe: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    @Relationship(deleteRule: .cascade) var ingredients: [Ingredient]
    var steps: [String]
    var category: String
    var dietaryTags: [String]

    init(name: String, ingredients: [Ingredient], steps: [String], category: String, dietaryTags: [String]) {
        self.name = name
        self.ingredients = ingredients
        self.steps = steps
        self.category = category
        self.dietaryTags = dietaryTags
    }
}
