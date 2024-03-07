//
//  ContentView.swift
//  Yummi
//
//  Created by Shi, Simba (Coll) on 23/01/2024.
//

import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    var quantity: Int
    let unit: String
    
    var information: String {
        "Name: \(name)\nQuantity: \(quantity)\(unit)\nCategory: \(category)"
    }
    
    static func example() -> Ingredient {
        return Ingredient(name: "Egg", category: "Poultry", quantity: 2, unit: "pcs")
    }
}

struct InventoryIngredient: Identifiable {
    let id = UUID()
    var ingredient: Ingredient
    var expiryDate: Date
    
    var information: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: expiryDate)
        return "\(ingredient.information)\nExpiry: \(formattedDate)"
    }
    
    static func example() -> InventoryIngredient {
        return InventoryIngredient(ingredient: Ingredient.example(), expiryDate: Date())
    }
}

struct IngredientView: View {
    @State private var ingredients = [
        InventoryIngredient(ingredient: Ingredient(name: "Tomato", category: "Vegetable", quantity: 3, unit: "pcs"), expiryDate: Date())
    ]
    @State private var newName = ""
    @State private var newCategory = ""
    @State private var newQuantity: Int = 0
    @State private var newUnit = ""
    @State private var newExpiryDate = Date()
    
    @State private var showingAddIngredientSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Ingredients List")) {
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.information)
                    }
                    .onDelete(perform: deleteItems)
                }
                
                Section(header: Text("Add new ingredient")) {
                    TextField("Name", text: $newName)
                    TextField("Category", text: $newCategory)
                    TextField("Unit", text: $newUnit)
                    Stepper("Quantity: \(newQuantity)", value: $newQuantity, in: 0...100)
                    DatePicker("Expiry date", selection: $newExpiryDate, displayedComponents: .date)
                    Button("Add ingredient") {
                        let newIngredient = InventoryIngredient(ingredient: Ingredient(name: newName, category: newCategory, quantity: newQuantity, unit: newUnit), expiryDate: newExpiryDate)
                        ingredients.append(newIngredient)
                        clearInputFields()
                    }
                }
            }
            .navigationTitle("Ingredients")
        }
    }
    
    private func clearInputFields() {
        newName = ""
        newCategory = ""
        newQuantity = 0
        newUnit = ""
        newExpiryDate = Date()
    }
    
    private func deleteItems(offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}

//#Preview {
//    IngredientView()
//}
