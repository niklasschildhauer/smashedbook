//
//  View.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

@Observable 
class RecipeEditViewModel: Identifiable {
    let recipesDataSource: RecipesDataSource
    
    var recipeToEdit: RecipeModel
    
    init(recipesDataSource: RecipesDataSource, recipeToEdit: RecipeModel) {
        self.recipesDataSource = recipesDataSource
        self._recipeToEdit = recipeToEdit
    }
    
    func save() async {
        recipesDataSource.save(recipe: recipeToEdit)
    }
}

struct RecipeEditView: View {
    @Bindable var viewModel: RecipeEditViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: LayoutConstants.verticalSpacing) {
                RecipeEditNameLabelView(name: $viewModel.recipeToEdit.title)
                RecipeEditMetaInformationSectionView()
                RecipeEditContentSectionView(title: "Zutaten", recipeContent: .constant([])) {
                    RecipeEditPortionCounterView()
                }
                RecipeEditContentSectionView(title: "Anleitung", recipeContent: .constant([]))
            }
            .padding(.horizontal, LayoutConstants.horizontalSpacing)
            .padding(.vertical, LayoutConstants.verticalSpacing)
        }
    }
}

#Preview {
    RecipeEditView(viewModel: RecipeEditViewModel(recipesDataSource: RecipesDataSource(), recipeToEdit: recipeModelMock))
}
