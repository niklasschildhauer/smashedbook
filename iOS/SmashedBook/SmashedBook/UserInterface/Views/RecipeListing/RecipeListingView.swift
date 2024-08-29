//
//  RecipeListingVIew.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeListingView: View {
    @Binding var recipes: [RecipeModel]
    
    var oneColumnGrid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: LayoutConstants.horizontalSpacing), count: 1)
    var showDetails: (RecipeModel) -> Void
    

    var body: some View {
        ScrollView {
            if recipes.count == 0 {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                LazyVGrid(columns: oneColumnGrid, spacing: LayoutConstants.verticalSpacing) {
                    ForEach(recipes) { recipe in
                        Button(action: {
                            showDetails(recipe)
                        }, label: {
                            RecipeCardView(recipe: recipe)
                        })
                    }
                }
                .padding(.horizontal, LayoutConstants.safeAreaSpacing)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeListingView(recipes: .constant([recipeModelMock]), showDetails: { _ in
            print("Recipe is clicked")
        })
    }
}
