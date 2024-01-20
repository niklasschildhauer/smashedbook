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
            RecipeEditNameLabelView(name: $recipe.title)
            RecipeEditTitleImageSectionView(addAttachmentCoordinator: $addAttachmentCoordinator)
            RecipeEditMetaInformationSectionView(metaInformationModel: $recipe.metaInformation)
            RecipeEditIngredientSectionView(ingredients: $recipe.ingredients)
            RecipeEditAttachmentSectionView(attachments: $recipe.attachments, addAttachmentCoordinator: $addAttachmentCoordinator)
        }
    }
}

#Preview {
    RecipeEditView(recipe: .constant(recipeModelMock), addAttachmentCoordinator: .constant(nil))
}
