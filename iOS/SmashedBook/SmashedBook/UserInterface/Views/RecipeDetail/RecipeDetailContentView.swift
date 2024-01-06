//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Binding var recipe: RecipeModel
    
    var body: some View {
        VStack (spacing: LayoutConstants.verticalSpacing) {
            RecipeDetailMetainformationView(metainformation: recipe.metaInformation)
                .padding(.vertical ,LayoutConstants.verticalSpacing)
                .padding(.horizontal ,LayoutConstants.horizontalSpacing)
            
            ForEach(0..<5) { _ in
                Text("Das ist ein Test")
            }
        }
    }
}

#Preview {
    RecipeDetailContentView(recipe: .constant(recipeModelMock))
}

