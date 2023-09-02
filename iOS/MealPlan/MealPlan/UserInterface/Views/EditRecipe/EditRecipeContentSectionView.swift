//
//  EditRecipeIngredientsSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct EditRecipeContentSectionView: View {
    var title: String
    
    var body: some View {
        ListSectionView(title: title) {
            EditRecipeAddContentButtonListCellView()
        }
    }
}

struct EditRecipeContentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeContentSectionView(title: "Testüberschrift")
    }
}
