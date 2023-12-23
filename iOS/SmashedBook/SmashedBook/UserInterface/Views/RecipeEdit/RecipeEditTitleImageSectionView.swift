//
//  RecipeEditTitleImageSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 12.11.23.
//

import SwiftUI

struct RecipeEditTitleImageSectionView: View {
    var didTapSelectTitleImage: (() -> Void)
    
    var body: some View {
        ListSectionView(title: "Meta Information") {
            Button(action: {
                didTapSelectTitleImage()
            }, label: {
                IconLabelListCellView(title: "Bild auswählen", image: Image(systemName: "plus"))
            })
        }
    }
}

#Preview {
    RecipeEditTitleImageSectionView {
        print("Select title image")
    }
}
