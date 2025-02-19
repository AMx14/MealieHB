# MealieHB - Recipe Organizer with Meal Planning  
[Demo Video](https://drive.google.com/file/d/1Qe-yq_Mj1_QwmTXcrGsJDYQp3ETzhtsf/view?usp=sharing)  

## Overview  
MealieHB is a Swift-based iOS application designed to help users plan meals, organize recipes, and generate shopping lists efficiently. It allows users to:


- Store and manage recipes
- Plan meals for different days of the week
- Generate shopping lists based on planned meals
- Persist data using SwiftData for offline access
- Export meal plans and recipes as JSON/CSV

## Tech Stack

- **Swift** (SwiftUI for UI, SwiftData for persistence)
- **MVVM Architecture** for better code organization
- **SwiftData** for database storage and persistence
- **GitHub** for version control

## Features

### Core Functionality
- **Recipe Management:** Add, edit, and delete recipes with ingredients and steps
- **Meal Planning:** Assign meals to specific days of the week
- **Shopping List:** Automatically generates a shopping list based on planned meals
- **Data Persistence:** Saves data locally and reloads on app restart
- **Export & Import:** Export recipes and meal plans as JSON/CSV

## Project Structure

```
Mealie/                                  # Root directory of the project
├── Mealie/                              # Main app module
│   ├── Models/                          # Data structures representing core entities
│   │   ├── Recipe.swift                 # Defines the Recipe model (ID, name, ingredients, steps, tags)
│   │   ├── Ingredient.swift              # Defines Ingredient model (name, quantity, unit)
│   │   ├── MealPlan.swift                # Defines MealPlan model (recipes mapped to days)
│   │   ├── ShoppingList.swift            # Represents shopping list items aggregated from meal plans
│   │
│   ├── ViewModels/                       # Business logic (MVVM pattern)
│   │   ├── RecipeViewModel.swift         # Manages recipes: CRUD operations, filtering, and validation
│   │   ├── MealPlannerViewModel.swift    # Handles meal planning logic, assigning recipes to days
│   │   ├── ShoppingListViewModel.swift   # Generates a shopping list based on meal plans
│   │   ├── CalorieTrackerViewModel.swift # Placeholder for future calorie tracking feature
│   │
│   ├── Views/                            # SwiftUI screens handling UI interactions
│   │   ├── RecipeListView.swift          # Displays the list of saved recipes
│   │   ├── RecipeDetailView.swift        # Shows detailed view of a selected recipe with edit options
│   │   ├── MealPlannerView.swift         # UI for assigning recipes to meal plans
│   │   ├── ShoppingListView.swift        # Displays an auto-generated shopping list
│   │   ├── AddRecipeView.swift           # UI for adding new recipes with form validation
│   │
│   ├── Data/                             # Handles storage and persistence of app data
│   │   ├── SwiftDataStore.swift          # Implements data persistence using SwiftData (formerly Core Data)
│   │   ├── DataStoreProtocol.swift       # Protocol defining the interface for storing/retrieving data
│   │
│   ├── Preview Content/                  # Assets used for SwiftUI Previews
│   │   ├── Preview Assets                 # Sample images/icons for UI previews
│   │   └── Assets                         # App-wide assets like icons, images, colors
│   │
│   ├── ContentView.swift                  # Initial screen that loads the main UI
│   ├── MealieApp.swift                     # Entry point of the app, initializes the app environment
│
├── MealieTests/                           # Unit Testing directory
│   ├── RecipeViewModelTests.swift         # Tests for RecipeViewModel (validations, CRUD, filtering)
│   ├── MealPlannerViewModelTests.swift    # Tests for MealPlannerViewModel (meal plan logic)
│
└── MealieUITests/                         # UI Testing directory
    ├── MealieUITests.swift                # General UI test cases for app interactions
    ├── MealieUITestsLaunchTests.swift     # Ensures the app launches correctly without crashes

```

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/AMx14/MealieHB.git
cd MealieHB
```

### 2. Open in Xcode
- Open `Mealie.xcodeproj` in Xcode
- Ensure you have **Xcode 15+** installed

### 3. Run the App
- Select an iOS simulator or a physical device
- Press `Cmd + R` to build and run

## Usage Guide

### 1. Adding Recipes
- Navigate to the **Recipes** section
- Click **Add Recipe**, enter details, and save

### 2. Planning Meals
- Go to the **Meal Planner** tab
- Select a day and assign recipes to it

### 3. Viewing Shopping List
- The app automatically generates a shopping list based on planned meals

### 4. Exporting Data
- Navigate to **Settings** to export/import JSON or CSV files

## Future Enhancements

- **Cloud Sync** for cross-device access
- **More Dietary Filters** for customized meal plans
- **Enhanced UI/UX Improvements**

## License
This project is for educational purposes.

## Contact
For any queries, reach out via GitHub Issues.
