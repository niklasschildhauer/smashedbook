//
//  DetailRecipeCoordinatorView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import SwiftUI

@Observable class DetailRecipeCoordinator: Coordinator {
    typealias CoordinatorView = DetailRecipeCoordinatorView
    
    var rootView: DetailRecipeCoordinatorView {
        DetailRecipeCoordinatorView(coordinator: self)
    }
    
    var recipesDataSource: RecipesDataSource
    var recipeModel: RecipeModel
    var recipeEditModel: RecipeEditViewModel? = nil
    
    var isEditing: Bool {
        recipeEditModel != nil
    }
    
    init(recipesDataSource: RecipesDataSource = RecipesDataSource(), recipeModel: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self.recipeModel = recipeModel
    }

    func start() {
        
    }
    
    func didTapEditButton() async {
        if let recipeEditModel = recipeEditModel {
            await recipeEditModel.save()
            // TODO: Is this a suitable solution?
            recipeModel = recipeEditModel.recipeToEdit
            self.recipeEditModel = nil
        } else {
            recipeEditModel = RecipeEditViewModel(recipesDataSource: recipesDataSource, recipeToEdit: recipeModel)
        }
    }
}

struct DetailRecipeCoordinatorView: View {
    @State var coordinator: DetailRecipeCoordinator
 
    var editButtonTitle: String {
        !coordinator.isEditing ? "Bearbeiten" : "Speichern"
    }
    
    var body: some View {
        contentView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .bottomToolbar {
                HStack(spacing: LayoutConstants.horizontalSpacing){
                    IconLabelFilledButtonView(title: editButtonTitle) {
                        Task {
                            await coordinator.didTapEditButton()
                        }
                    }
                    .uiTestIdentifier("editRecipeButton")
                }
            }
            .onAppear {
                coordinator.start()
            }
    }
    
    @ViewBuilder func contentView() -> some View {
        if let recipeEditModel = coordinator.recipeEditModel {
            RecipeEditView(viewModel: recipeEditModel)
        } else {
            RecipeDetailView(recipe: $coordinator.recipeModel)
        }
    }
}

#Preview {
    DetailRecipeCoordinatorView(coordinator: DetailRecipeCoordinator(recipeModel: recipeModelMock))
}
