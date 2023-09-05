//
//  SeeAllViewOutput.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

protocol SeeAllViewOutput {
    var networkManager: NetworkManager { get set }
    var trendingNowRecipes: [SearchRecipe] { get set }
    var recentRecipe: [RecipeInfo] { get set }
    
    func fetchData(mealType: String)
    func cellTapped()
    func saveButtonTapped()
}
