//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (spacing: LayoutConstants.verticalSpacing) {
                RecipeDetailHeaderView(recipe: recipe)
                attachments
            }
        }
//        .edgesIgnoringSafeArea(.top)
    }
    
    var attachments: some View {
        RecipeDetailAttachmentsView(attachments: $recipe.attachments)
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}

