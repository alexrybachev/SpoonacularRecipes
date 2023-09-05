//
//  StorageManager.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 04.09.2023.
//

import RealmSwift

import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Methods
    
//    func save(recipes: RecipesRealm) {
//        try! realm.write {
//            realm.add(recipes)
//        }
//    }
    
    func save(recipes: [RecipeInfoRealm]) {
        try! realm.write {
            realm.add(recipes)
        }
    }
    
    func save(recipe: RecipeInfoRealm) {
        
    }
    
    
    
}
