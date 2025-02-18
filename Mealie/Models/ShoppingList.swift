//
//  ShoppingList.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import Foundation
import SwiftData

@Model
final class ShoppingList: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    @Relationship(deleteRule: .cascade) var ingredients: [Ingredient]

    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
}
