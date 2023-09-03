//
//  EditRecipeIngredientsSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct EditRecipeContentSectionView<TrailingAction: View>: View {
    var title: String
    var trailingAction: () -> TrailingAction
    
    init(title: String,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = { EmptyView() }) {
        self.title = title
        self.trailingAction = trailingAction
    }
    
    var body: some View {
        ListSectionView(title: title, content: {
            EditRecipePickPhotoButtonListCellView()
        }, trailingAction: trailingAction)
    }
}

struct EditRecipeContentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeContentSectionView(title: "Testüberschrift")
    }
}
