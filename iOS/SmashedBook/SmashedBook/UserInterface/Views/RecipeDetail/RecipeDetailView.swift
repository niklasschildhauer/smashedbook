//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    var didTapShowAttachment: ((RecipeAttachmentModel) -> Void)?
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (spacing: LayoutConstants.verticalSpacing) {
                RecipeDetailHeaderView(recipe: recipe)
                RecipeDetailAttachmentsView(attachments: $recipe.attachments,
                                            didTapShowAttachment: didTapShowAttachment)
            }
        }
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}

