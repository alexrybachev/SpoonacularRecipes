//
//  RecipeInfoRealm.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 02.09.2023.
//

import Foundation
import RealmSwift

//class RecipesRealm: Object {
//    @Persisted var recipes = List<RecipeInfoRealm>()
//}

class RecipeInfoRealm: Object {
    @Persisted var id = UUID()
    @Persisted var title = ""
    @Persisted var serves = ""
    @Persisted var cookTime = ""
    @Persisted var imageData = Data()
    @Persisted var ingredients = List<IngredientRealm>()
}

class IngredientRealm: Object {
    @Persisted var name = ""
    @Persisted var quantity = ""
}

