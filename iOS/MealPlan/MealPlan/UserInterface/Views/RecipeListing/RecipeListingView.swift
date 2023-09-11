//
//  RecipeListingVIew.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI


class RecipeListingViewModel: ObservableObject {
    @Published var recipiesList = [Recipe]()
    private var recipieInteractor: RecipeInteractoring
    
    init(recipieInteractor: RecipeInteractoring) {
        self.recipieInteractor = recipieInteractor
    }
    
    func reload() {
        Task {
            let updatedRecipiesList = await recipieInteractor.loadRecipies()
            DispatchQueue.main.sync {
                recipiesList = updatedRecipiesList
            }
        }
    }
}

struct RecipeListingView: View {
    // Todo: How should i pass the object in?
    @StateObject var viewModel = RecipeListingViewModel(recipieInteractor: RecipeInteractor())
    
    private var twoColumnGrid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: LayoutConstants.horizontalPadding), count: 2)
    
    var body: some View {
        ScrollView {
            if viewModel.recipiesList.count == 0 {
                ProgressView()
            } else {
                LazyVGrid(columns: twoColumnGrid, spacing: LayoutConstants.verticalPadding) {
                    ForEach(viewModel.recipiesList, id: \.id) { recipe in
                        RecipeCardView()
                    }
                }
                .padding(.horizontal, LayoutConstants.horizontalPadding)
            }
        }
        .onAppear() {
            viewModel.reload()
        }
    }
}

struct RecipeListingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListingView()
    }
}
