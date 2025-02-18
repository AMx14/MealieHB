//
//  MealPlannerView.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import SwiftUI
import SwiftData

struct MealPlannerView: View {
    @EnvironmentObject var mealPlannerViewModel: MealPlannerViewModel
    @State private var showingAddMeal = false
    @State private var selectedDate = Date()

    private let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            List {
                DatePicker("Week Starting", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .onChange(of: selectedDate) { newDate in
                        mealPlannerViewModel.fetchMealPlans(for: newDate)
                    }

                ForEach(weekDays, id: \.self) { day in
                    let mealsForDay = mealPlannerViewModel.mealsFor(day: day, date: selectedDate)

                    if mealsForDay.isEmpty {
                        Text("\(day): No meals planned")
                            .foregroundColor(.gray)
                    } else {
                        MealDayView(day: day, meals: mealsForDay)
                    }
                }
            }
            .navigationTitle("Meal Planner")
            .toolbar {
                Button(action: { showingAddMeal = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddMeal) {
                AddMealView(selectedDate: Date()) 
            }
        }
        .onAppear {
            mealPlannerViewModel.fetchMealPlans(for: selectedDate)
        }
    }
}

struct MealDayView: View {
    let day: String
    let meals: [Meal]

    var body: some View {
        VStack(alignment: .leading) {
            Text(day)
                .font(.headline)
            if meals.isEmpty {
                Text("No meal planned")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(Array(meals.enumerated()), id: \.offset) { index, meal in
                    if let recipe = meal.recipe {
                        Text(recipe.name)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mealPlannerViewModel: MealPlannerViewModel
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    @State private var selectedDay = "Monday"
    @State private var selectedRecipe: Recipe?
    var selectedDate: Date

    private let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            Form {
                Picker("Day", selection: $selectedDay) {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day).tag(day)
                    }
                }

                if !recipeViewModel.recipes.isEmpty {
                    Picker("Recipe", selection: Binding(
                        get: { selectedRecipe?.id ?? recipeViewModel.recipes.first?.id ?? UUID() },
                        set: { newID in selectedRecipe = recipeViewModel.recipes.first { $0.id == newID } }
                    )) {
                        Text("None").tag(UUID()) // Dummy UUID for None selection
                        ForEach(recipeViewModel.recipes) { recipe in
                            Text(recipe.name).tag(recipe.id)
                        }
                    }
                } else {
                    Text("No recipes available")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Add Meal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMeal()
                    }
                }
            }
        }
        .onAppear {
            recipeViewModel.fetchRecipes()
        }
    }

    private func saveMeal() {
        let calendar = Calendar.current
        let startOfWeek = calendar.startOfDay(for: selectedDate)

        if var existingMealPlan = mealPlannerViewModel.mealPlans.first(where: { $0.weekStartDate == startOfWeek }) {
            existingMealPlan.meals.append(Meal(day: selectedDay, recipe: selectedRecipe))
            mealPlannerViewModel.saveMealPlan(existingMealPlan)
        } else {
            let newMealPlan = MealPlan(weekStartDate: startOfWeek, meals: [Meal(day: selectedDay, recipe: selectedRecipe)])
            mealPlannerViewModel.saveMealPlan(newMealPlan)
        }
        dismiss()
    }
}
