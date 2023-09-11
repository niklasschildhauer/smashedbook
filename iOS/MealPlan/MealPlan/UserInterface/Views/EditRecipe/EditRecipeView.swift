//
//  EditRecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

@Observable class EditRecipeViewModel {
    // add RecipeInteractor as Environment in here. Entweder als Dependency Injection oder als DIWrapper oder direkt als Environment. Je nachdem welcher Mechanismus besser funktioniert.
    var recipe = Recipe()
    
    func save() {
        print(recipe.title)
        print(recipe.ingredients)
    }
    
    static func create(from recipe: Recipe) -> EditRecipeViewModel {
        let viewModel = EditRecipeViewModel()
        viewModel.recipe = recipe
        
        return viewModel
    }
}


struct EditRecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: LayoutConstants.verticalPadding) {
                EditRecipeNameLabelView(name: $recipe.title)
                EditRecipeMetaInformationSectionView()
                EditRecipeContentSectionView(title: "Zutaten", content: $recipe.ingredients)  {
                    EditRecipePortionCounterView()
                }
                EditRecipeContentSectionView(title: "Anleitung", content: $recipe.steps)
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
            .padding(.vertical, LayoutConstants.verticalPadding)
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    @State static var recipe = recipeModelMock
    static var previews: some View {
        EditRecipeView(recipe: EditRecipeView_Previews.$recipe)
    }
}

