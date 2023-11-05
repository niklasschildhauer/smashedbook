//
//  RecipeEditIngredientsSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct RecipeEditContentSectionView<TrailingAction: View, AddButton: View>: View {
    let title: String
    @ViewBuilder var trailingAction: () -> TrailingAction
    @ViewBuilder var addButton: () -> AddButton
    @Binding var recipeContent: [RecipeContentModel]
    
    init(title: String, 
         recipeContent: Binding<[RecipeContentModel]>,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = {EmptyView()},
         @ViewBuilder addButton: @escaping () -> AddButton = {EmptyView()}) {
        self.title = title
        self._recipeContent = recipeContent
        self.trailingAction = trailingAction
        self.addButton = addButton
    }
    
    var body: some View {
        ListSectionView(title: title, content: {
            ForEach($recipeContent.indices, id: \.self) { index in
                let item = $recipeContent[index]
                switch item.type.wrappedValue {
                case .image(let imageUrl):
                    RecipeEditImageListCellView(image: Image("ExampleRecipe"))
                }
            }
            addButton()
        }, trailingAction: trailingAction)
    }
}


struct RecipeEditContentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditContentSectionView(title: "Titel", recipeContent: .constant([]))
    }
}

