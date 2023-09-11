//
//  EditRecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

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

