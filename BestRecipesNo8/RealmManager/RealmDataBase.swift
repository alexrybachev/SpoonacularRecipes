//
//  RealmDataBase.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 09.09.2023.
//

import RealmSwift
import Foundation

class RealmDataBase {
    
    /*
    
    // MARK: - Properties
    
    static let shared = RealmDataBase()

    private let realm = try! Realm()
    private var items: Results<RealmRecipe>!
    
    // MARK: - Initialization
    
    private init() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    // MARK: - Public methods
    
    func isItemSaved(withId id: Int) -> Bool {
        let itemsWithId = realm.objects(RealmRecipe.self).filter("id = %@", id)
        return !itemsWithId.isEmpty
    }
    
    func write<T: RecipeProtocol>(recipe: T) {
        
        let realmRecipe = RealmRecipe()
        
        realmRecipe.id = recipe.id
        
        if let title = recipe.title {
            realmRecipe.title = title
        }
        
        if let imageString = recipe.image {
            guard let imageUrl = URL(string: imageString) else { return }
            
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                realmRecipe.image = data
                
                DispatchQueue.main.async {
                    try! self.realm.write({
                        self.realm.add(realmRecipe)
                    })
                }
            }.resume()
        }
    }
    
    func read(completion: @escaping (Results<RealmRecipe>) -> ()) {
        items = realm.objects(RealmRecipe.self)
        completion(items)
    }
    
    func deleteitem(withId id: Int) {
        
        try! realm.write {
            let recipe = realm.objects(RealmRecipe.self).where {
                $0.id == id
            }
            realm.delete(recipe)
        }
    }

    func deleteAll() {
        
        try! realm.write {
            let allRecipes = realm.objects(RealmRecipe.self)
            realm.delete(allRecipes)
        }
        
    }
     */
}
