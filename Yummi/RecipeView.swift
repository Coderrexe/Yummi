//
//  RecipeView.swift
//  Yummi
//
//  Created by Shi, Simba (Coll) on 02/02/2024.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [Ingredient]
    let isFavourite: Bool
    let rating: Int
    let numPeopleServed: Int
    let imageFilePath: String
    
    #if DEBUG
    static func exampleRecipes() -> [Recipe] {
        [
            Recipe(name: "Spaghetti Bolognese", ingredients: [.example()], isFavourite: true, rating: 5, numPeopleServed: 1, imageFilePath: "spaghetti_bolognese"),
            Recipe(name: "Fillet Mignon", ingredients: [.example()], isFavourite: false, rating: 5, numPeopleServed: 2, imageFilePath: "fillet_mignon"),
            Recipe(name: "Chicken Curry", ingredients: [.example()], isFavourite: true, rating: 5, numPeopleServed: 3, imageFilePath: "chicken_curry")
        ]
    }
    #endif
}


struct RecipeView: View {
    @State var recipes: [Recipe]
    @State private var searchText = ""
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.ingredients.contains(where: {$0.name.localizedCaseInsensitiveContains(searchText)})
            }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    VStack(alignment: .leading) {
                        Text(recipe.name).bold()
                        Text("Serves: \(recipe.numPeopleServed)").font(.subheadline).foregroundStyle(.secondary)
                    }
                    Image(recipe.imageFilePath).resizable().frame(width: 100.0, height: 100.0)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Recipes")
            .toolbar {
                NavigationLink(destination: AddRecipeView(recipes: $recipes)) {
                    Text("Add")
                }
            }
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var servings: Int = 1
    
    var scaledIngredients: [Ingredient] {
        recipe.ingredients.map { ingredient in
            let scaledQuantity = ingredient.quantity * servings
            return Ingredient(name: ingredient.name, category: ingredient.category, quantity: scaledQuantity, unit: ingredient.unit)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name).font(.title)
            Stepper("Servings: \(servings)", value: $servings, in: 1...20)
            ForEach(scaledIngredients, id: \.id) { ingredient in
                Text("\(ingredient.quantity) \(ingredient.unit) \(ingredient.name)")
            }
            Text("Rating: \(String(repeating: "⭐️", count: recipe.rating))")
            Text("Number of people served: \(servings)")
            Image(recipe.imageFilePath).resizable().frame(width: 250.0, height: 250.0)
        }
        .padding()
    }
}

struct AddRecipeView: View {
    @Binding var recipes: [Recipe]
    @State private var name: String = ""
    @State private var ingredientText: String = ""
    @State private var rating: Int = 1
    @State private var numPeopleServed: Int = 1

    var body: some View {
        Form {
            TextField("Recipe Name", text: $name)
            TextField("Ingredients (comma separated)", text: $ingredientText)
            Stepper("Rating: \(rating)", value: $rating, in: 1...5)
            Stepper("How many people served: \(rating)", value: $rating, in: 1...5)
            Button("Add Recipe") {
                let newIngredients = ingredientText.split(separator: ",").map { Ingredient(name: String($0).trimmingCharacters(in: .whitespacesAndNewlines), category: "Misc", quantity: 1, unit: "pcs") }
                let newRecipe = Recipe(name: name, ingredients: newIngredients, isFavourite: false, rating: rating, numPeopleServed: numPeopleServed, imageFilePath: "")
                recipes.append(newRecipe)
            }
        }
        .navigationTitle("Add New Recipe")
    }
}


//#Preview {
//    RecipeView(recipes: Recipe.exampleRecipes())
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
