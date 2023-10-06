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
                case .description(let descriptionText):
                    RecipeEditDescriptionListCellView(description: descriptionText, onEdit: { editedDescription in
                        guard let index = recipeContent.firstIndex(of: item.wrappedValue) else {
                            return
                        }
                        recipeContent[index].type = .description(descriptionText: editedDescription)
                    })
                case .image(let imageUrl):
                    RecipeEditImageListCellView(image: Image("ExampleRecipe"))
                case .ingredient(let value, let unit):
                    HStack {
                        Text(value)
                        Text(unit.rawValue)
                    }
                }
            }
            addButton()  
        }, trailingAction: trailingAction)
    }
}


struct RecipeEditContentSectionView_Previews: PreviewProvider {
    @State static var content = [RecipeContentModel(type: .description(descriptionText: "Test")), RecipeContentModel(type: .ingredient(value: "Test", unit: .gram))]
    static var previews: some View {
        RecipeEditContentSectionView(title: "Titel", recipeContent: $content)
    }
}

