//
//  RecipeContentsIngredientView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 07.12.24.
//

import SwiftUI

struct RecipeDetailIngredientView: View {
    @Binding var ingredient: RecipeIngredientModel
    
    var body: some View {
        HStack(alignment: .top) {
            Text(ingredient.name)
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(ingredient.value)
                Text(ingredient.unit.rawValue)
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundStyle(.black)
            }
        }
    }
}
