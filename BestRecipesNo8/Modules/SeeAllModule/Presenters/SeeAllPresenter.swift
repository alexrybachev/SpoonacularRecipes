//
//  SeeAllPresenter.swift
//  BestRecipesNo8
//
//  Created by Aleksandr Rybachev on 29.08.2023.
//

import Foundation

final class SeeAllPresenter {
    weak var view: SeeAllViewInput?
    private let router: SeeAllRouterInput
    var networkManager = NetworkManager.shared
    var popularCategoryRecipes: [SearchRecipe] = []
    var trendingNowRecipes: [SearchRecipe] = []
    var recentRecipe: [RecipeInfo] = []
   // private let settingsManager: SettingsManagerProtocol

    init(router: SeeAllRouterInput) {
        
        self.router = router 
        //self.settingsManager = settingsManager
    }
}

extension SeeAllPresenter: SeeAllViewOutput {

    func cellTapped() {
        self.router.routeToRecipeDetailScreen()
    }
    
    func saveButtonTapped() {
        //
    }
    
    func fetchData(mealType: String) {
        networkManager.getRecipesWithMealType(for: mealType) { result in
            switch result {
            case .success(let recipes):
                self.popularCategoryRecipes =  recipes.results ?? []
                guard let view = self.view else { return }
                print("Популярная категория: \(self.popularCategoryRecipes)")
                view.getPopularRecipes()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

        }
        
        
    }

