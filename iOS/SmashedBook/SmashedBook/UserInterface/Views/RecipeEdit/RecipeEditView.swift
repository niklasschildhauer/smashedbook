//
//  View.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct RecipeEditView: View {
    @Binding var recipe: RecipeModel
    @Binding var addAttachmentCoordinator: RecipeAddImageCoordinator?
    
    var body: some View {
        List {
            RecipeEditNameSectionView(name: $recipe.title)
            RecipeEditIngredientSectionView(ingredients: $recipe.ingredients)
            RecipeEditAttachmentSectionView(attachments: $recipe.attachments, addAttachmentCoordinator: $addAttachmentCoordinator)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RecipeEditView(recipe: .constant(recipeModelMock), addAttachmentCoordinator: .constant(nil))
}
