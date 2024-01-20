//
//  RecipeListingVIew.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeListingView: View {
    @Binding var recipes: [RecipeModel]
    
    private var twoColumnGrid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: LayoutConstants.horizontalSpacing), count: 2)
    var didTapOpenRecipe: (RecipeModel) -> Void
    
    init(recipes: Binding<[RecipeModel]>, didTapOpenRecipe: @escaping (RecipeModel) -> Void) {
        self._recipes = recipes
        self.didTapOpenRecipe = didTapOpenRecipe
    }
    
    var body: some View {
        ScrollView {
            if recipes.count == 0 {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                LazyVGrid(columns: twoColumnGrid, spacing: LayoutConstants.verticalSpacing) {
                    ForEach(recipes) { recipe in
                        Button(action: {
                            didTapOpenRecipe(recipe)
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
        RecipeListingView(recipes: .constant([recipeModelMock]), didTapOpenRecipe: { _ in
            print("Recipe is clicked")
        })
    }
}
