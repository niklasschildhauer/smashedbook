//
//  RecipeListingVIew.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeListingView: View {
    // TODO: How should i pass this in?
    @Binding var recipes: [RecipeModel]
    
    private var twoColumnGrid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: LayoutConstants.horizontalSpacing), count: 2)
    
    init(recipes: Binding<[RecipeModel]>) {
        self._recipes = recipes
    }
    
    
    var body: some View {
        ScrollView {
            if recipes.count == 0 {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                LazyVGrid(columns: twoColumnGrid, spacing: LayoutConstants.verticalSpacing) {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeListingView(recipes: .constant([recipeModelMock]))
    }
}

//import Combine
//
//@Observable class RecipeListingViewModel {
//    var recipesList = [RecipeModel]()
//    private var recipeInteractor: RecipeInteractoring
//    var cancellables = [AnyCancellable]()
//    var recipes: LoadingData<[RecipeModel]> = .notStarted
//
//    let repoWeb = RecipeWebRepository()
//    var cancellabels = [AnyCancellable]()
//
//    init(recipeInteractor: RecipeInteractoring) {
//        self.recipeInteractor = recipeInteractor
//        self.reload()
//    }
//
//    func reload() {
//        Task {
//            let updatedRecipesList = await recipeInteractor.loadRecipes()
//            DispatchQueue.main.sync {
//                recipesList = updatedRecipesList
//            }
//        }
//    }
//
////    func loadRecipes() {
//        repoWeb.loadRecipes()
//            .sink(receiveCompletion: { _ in
//                print("Es funktioniert hier!")
//            }, receiveValue: { [weak self] data in
//                self?.recipesList = data
//            })
//            .store(in: &cancellabels)
//    }
//
//    func loadRecipes2() {
//        repoWeb.loadRecipes()
//            .sink(receiveCompletion: { _ in
//                print("Es funktioniert hier auch!")
//            }, receiveValue: { [weak self] data in
//                self?.recipesList = data
//            })
//            .store(in: &cancellabels)
//    }
//}

