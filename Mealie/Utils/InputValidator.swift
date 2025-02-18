//
//  InputValidator.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import Foundation

enum ValidationError: LocalizedError {
    case emptyField(String)
    case invalidFormat(String)
    case tooShort(String, Int)
    case tooLong(String, Int)
    
    var errorDescription: String? {
        switch self {
        case .emptyField(let fieldName):
            return "\(fieldName) cannot be empty"
        case .invalidFormat(let message):
            return message
        case .tooShort(let fieldName, let minLength):
            return "\(fieldName) must be at least \(minLength) characters"
        case .tooLong(let fieldName, let maxLength):
            return "\(fieldName) must not exceed \(maxLength) characters"
        }
    }
}

struct InputValidator {
    static func validateRecipe(_ recipe: Recipe) throws {
        // Name validation
        try validateName(recipe.name)
        
        // Ingredients validation
        guard !recipe.ingredients.isEmpty else {
            throw ValidationError.emptyField("Ingredients")
        }
        
        // Steps validation
        guard !recipe.steps.isEmpty else {
            throw ValidationError.emptyField("Steps")
        }
        
        // Category validation
        try validateCategory(recipe.category)
    }
    
    static func validateName(_ name: String) throws {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.emptyField("Name")
        }
        
        guard name.count >= 2 else {
            throw ValidationError.tooShort("Name", 2)
        }
        
        guard name.count <= 100 else {
            throw ValidationError.tooLong("Name", 100)
        }
    }
    
    static func validateCategory(_ category: String) throws {
        guard !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.emptyField("Category")
        }
    }
    
    static func validateIngredient(_ ingredient: Ingredient) throws {
        guard !ingredient.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.emptyField("Ingredient name")
        }
        
        guard !ingredient.quantity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.emptyField("Ingredient quantity")
        }
    }
}
