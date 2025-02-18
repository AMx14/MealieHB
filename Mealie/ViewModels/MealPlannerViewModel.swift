//
//  MealPlannerViewModel.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class MealPlannerViewModel: ObservableObject {
    private let dataStore: DataStoreProtocol
    @Published var mealPlans: [MealPlan] = []
    @Published var errorMessage: String?

    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
        fetchMealPlans()  // Load meal plans on init
    }

    func fetchMealPlans(for date: Date? = nil) {
        Task {
            do {
                let allMealPlans = try await dataStore.fetchMealPlans(for: date ?? Date()) // ✅ Fixed Call
                mealPlans = date.map { selectedDate in
                    let calendar = Calendar.current
                    let startOfWeek = calendar.startOfDay(for: selectedDate)
                    return allMealPlans.filter {
                        calendar.isDate($0.weekStartDate, inSameDayAs: startOfWeek)
                    }
                } ?? allMealPlans
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func saveMealPlan(_ mealPlan: MealPlan) {
        Task {
            do {
                try await dataStore.saveMealPlan(mealPlan)
                fetchMealPlans(for: mealPlan.weekStartDate)  // Refresh data after saving
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func deleteMealPlan(_ mealPlan: MealPlan) {
        Task {
            do {
                try await dataStore.deleteMealPlan(mealPlan)
                fetchMealPlans(for: mealPlan.weekStartDate)  // Refresh after deletion
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func mealsFor(day: String, date: Date) -> [Meal] {
        let calendar = Calendar.current
        let startOfWeek = calendar.startOfDay(for: date)

        return mealPlans
            .first(where: { calendar.isDate($0.weekStartDate, inSameDayAs: startOfWeek) })?
            .meals
            .filter { $0.day == day } ?? []
    }
}
