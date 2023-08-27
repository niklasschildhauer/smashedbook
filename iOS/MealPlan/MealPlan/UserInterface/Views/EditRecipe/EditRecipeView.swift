//
//  EditRecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct EditRecipeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: LayoutConstants.verticalPadding) {
                EditRecipeNameLabelView()
                EditRecipeMetaInformationSectionView()
                EditRecipeContentSectionView(title: "Zutaten")
                EditRecipeContentSectionView(title: "Anleitung")
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
            .padding(.vertical, LayoutConstants.verticalPadding)
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView()
    }
}
