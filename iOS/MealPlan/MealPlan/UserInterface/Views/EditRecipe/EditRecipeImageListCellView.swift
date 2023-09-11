//
//  EditImageListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct EditRecipeImageListCellView: View {
    @State private var offset: CGFloat = 0
    @State var image: Image
    
    var body: some View {
        ListCellWrapperView {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
        }
        .deleteSwipeGesture()
        .frame(height: 100)
    }
}

struct EditRecipeImageListCellView_Previews: PreviewProvider {    
    static var previews: some View {
        EditRecipeImageListCellView(image: Image("ExampleRecipe"))
    }
}
