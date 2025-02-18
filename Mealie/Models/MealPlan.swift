//
//  MealPlan.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//
import Foundation
import SwiftData

@Model
final class MealPlan {
    var weekStartDate: Date
    @Relationship(deleteRule: .cascade) var meals: [Meal]
    
    init(weekStartDate: Date, meals: [Meal]) {
        self.weekStartDate = weekStartDate
        self.meals = meals
    }
}

@Model
final class Meal {
    var day: String
    @Relationship(deleteRule: .nullify) var recipe: Recipe?
    
    init(day: String, recipe: Recipe?) {
        self.day = day
        self.recipe = recipe
    }
}
