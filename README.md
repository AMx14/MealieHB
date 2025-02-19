# MealieHB - Recipe Organizer with Meal Planning

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
Mealie/
├── Mealie/
│   ├── Models/                      # Data structures
│   │   ├── Recipe.swift             
│   │   ├── Ingredient.swift         
│   │   ├── MealPlan.swift           
│   │   ├── ShoppingList.swift       
│   │
│   ├── ViewModels/                   # Business logic
│   │   ├── RecipeViewModel.swift     
│   │   ├── MealPlannerViewModel.swift
│   │   ├── ShoppingListViewModel.swift
│   │   ├── CalorieTrackerViewModel.swift #For further Extension  
│   │
│   ├── Views/                        # SwiftUI screens
│   │   ├── RecipeListView.swift      
│   │   ├── RecipeDetailView.swift    
│   │   ├── MealPlannerView.swift     
│   │   ├── ShoppingListView.swift    
│   │   ├── AddRecipeView.swift       
│   │
│   ├── Data/                         # Storage & persistence
│   │   ├── SwiftDataStore.swift      # Swift Data implementation
│   │   ├── DataStoreProtocol.swift   # Interface for persistence
│   │
│   ├── Preview Content/              # Assets for SwiftUI previews
│   │   ├── Preview Assets
│   │   └── Assets
│   │
│   ├── ContentView.swift             # Main entry SwiftUI view
│   ├── MealieApp.swift               # Entry point of the app
│
├── MealieTests/                      # Unit Testing
│   ├── RecipeViewModelTests.swift    
│   ├── MealPlannerViewModelTests.swift 
│
└── MealieUITests/                    # UI Testing
    ├── MealieUITests.swift
    ├── MealieUITestsLaunchTests.swift
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
