//
//  RecipeEditContentView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 20.06.24.
//

import SwiftUI

struct RecipeEditContentsView: View {
    @Binding var recipeContents: [RecipeContentModel]
    var body: some View {
        ListSectionView(title: "Inhalt",
                        content: {
            ForEach(recipeContents.indices, id: \.self) { contentIndex in
                switch recipeContents[contentIndex].type {
                case .ingredient(let ingredient):
                    RecipeContentsIngredientView(ingredient: ingredient)
                case .step(let step):
                    Text(step.description)
                }
            }
        })
    }
}

#Preview {
    RecipeEditContentsView(recipeContents: .constant([]))
}
