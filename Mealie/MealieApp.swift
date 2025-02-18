import SwiftUI
import SwiftData

@main
struct MealieApp: App {
    let container: ModelContainer
    let dataStore: SwiftDataStore

    @StateObject private var recipeViewModel: RecipeViewModel
    @StateObject private var mealPlannerViewModel: MealPlannerViewModel
    @StateObject private var shoppingListViewModel: ShoppingListViewModel

    init() {
        do {
            let schema = Schema([
                Recipe.self,
                Ingredient.self,
                MealPlan.self,
                Meal.self,
                ShoppingList.self
            ])

            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            dataStore = SwiftDataStore(modelContext: container.mainContext)

            if try container.mainContext.fetch(FetchDescriptor<Recipe>()).isEmpty {
                let ingredient = Ingredient(name: "Sample Ingredient", quantity: "1 cup")
                let recipe = Recipe(
                    name: "Sample Recipe",
                    ingredients: [ingredient],
                    steps: ["Step 1", "Step 2"],
                    category: "Main Dish",
                    dietaryTags: ["Vegetarian"]
                )
                container.mainContext.insert(recipe)
                try container.mainContext.save()
            }

            let recipeVM = RecipeViewModel(dataStore: dataStore)
            let mealPlannerVM = MealPlannerViewModel(dataStore: dataStore)
            let shoppingListVM = ShoppingListViewModel(dataStore: dataStore)

            _recipeViewModel = StateObject(wrappedValue: recipeVM)
            _mealPlannerViewModel = StateObject(wrappedValue: mealPlannerVM)
            _shoppingListViewModel = StateObject(wrappedValue: shoppingListVM)

        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .environmentObject(recipeViewModel)
                .environmentObject(mealPlannerViewModel)
                .environmentObject(shoppingListViewModel)
        }
    }
}
