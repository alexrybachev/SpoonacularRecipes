//
//  DataManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 04.09.2023.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        
        if !UserDefaults.standard.bool(forKey: "done") {
            let ingredient = IngredientRealm()
            ingredient.name = "test name"
            ingredient.quantity = "test quantity"
            
            let ingred = IngredientRealm(value: ["bread", "10 kg"])
            
            let recipe = RecipeInfoRealm()
            recipe.id = UUID()
            recipe.title = "Test recipe"
            recipe.serves = " 25 tests"
            recipe.cookTime = "25 test min"
            recipe.imageData = (UIImage(systemName: "xmark")?.pngData() ?? Data())
            recipe.ingredients.append(ingredient)
            recipe.ingredients.append(ingred)
            
            let recipeTwo = RecipeInfoRealm()
            recipeTwo.id = UUID()
            recipeTwo.title = "TWO recipe"
            recipeTwo.serves = "TWO 25 tests"
            recipeTwo.cookTime = "TWO 25 test min"
            recipeTwo.imageData = (UIImage(systemName: "xmark")?.pngData() ?? Data())
            recipeTwo.ingredients.append(ingredient)
            recipeTwo.ingredients.append(ingred)
            
//            let recipes = RecipesRealm()
//            recipes.recipes.append(recipe)
//            recipes.recipes.append(recipeTwo)
            
            //        let recipes = RecipesRealm()
            //        recipes.recipes.append(recipe)
            DispatchQueue.main.async {
                StorageManager.shared.save(recipes: [recipe, recipeTwo])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
        
    }
}
