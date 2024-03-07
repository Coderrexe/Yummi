//
//  ContentView.swift
//  Yummi
//
//  Created by Shi, Simba (Coll) on 09/02/2024.
//

import SwiftUI

//struct ContentView: View {
//    @State private var showingRecipes = true
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Toggle("Show Recipes", isOn: $showingRecipes)
//                    .padding()
//                if showingRecipes {
//                    RecipeView(recipes: Recipe.exampleRecipes())
//                } else {
//                    IngredientView()
//                }
//            }
//            .navigationTitle("Yummi")
//        }
//    }
//}

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeView(recipes: Recipe.exampleRecipes())
                .tabItem {
                    Label("Recipes", systemImage: "list.dash")
                }
            
            IngredientView()
                .tabItem {
                    Label("Ingredients", systemImage: "leaf")
                }
        }
    }
}


#Preview {
    ContentView()
}
