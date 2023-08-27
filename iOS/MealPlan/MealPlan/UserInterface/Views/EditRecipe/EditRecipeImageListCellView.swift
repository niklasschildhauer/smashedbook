//
//  EditImageListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct EditRecipeImageListCellView: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ListCellWrapperView {
            Image("ExampleRecipe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
        }
        .deleteSwipeGesture()
        .frame(height: 200)
    }
}

struct EditRecipeImageListCellView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeImageListCellView()
    }
}
