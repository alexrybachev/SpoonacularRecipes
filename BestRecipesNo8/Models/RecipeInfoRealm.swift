//
//  RecipeInfoRealm.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 02.09.2023.
//

import Foundation
import RealmSwift

class RecipeInfoForRealm: Object {
    @Persisted var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var rating: Int = 0
    @Persisted var imageData: Data = Data()
    
    convenience init(id: Int, title: String, rating: Int, imageData: Data) {
        self.init()
        self.id = id
        self.title = title
        self.rating = rating
        self.imageData = imageData
    }
}
