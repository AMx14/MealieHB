//
//  Ingredient.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable {
    var name: String
    var quantity: String

    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
}
