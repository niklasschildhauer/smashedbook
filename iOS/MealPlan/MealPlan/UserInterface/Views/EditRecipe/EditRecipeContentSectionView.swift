//
//  RecipeEditIngredientsSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

protocol RecipeEditContent: Identifiable {
    var id: UUID { get }
}

extension RecipeEditContent {
    var id: UUID {
        UUID()
    }
}

struct RecipeEditContentSectionView<TrailingAction: View>: View {
    var title: String
    var trailingAction: () -> TrailingAction
    @Binding var recipeContent: [RecipeContentModel]
    
    init(title: String, recipeContent: Binding<[RecipeContentModel]>,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = {EmptyView()}) {
        self.title = title
        self._recipeContent = recipeContent
        self.trailingAction = trailingAction
    }
    
    var body: some View {
        ListSectionView(title: title, content: {
            ForEach($recipeContent, id: \.id) { item in
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
                Divider()
            }
            
            Button {
                withAnimation {
                    recipeContent.append(RecipeContentModel(type: .ingredient(value: "200", unit: .gram)))
                }
            } label: {
                IconLabelListCellView(title: "Foto hinzufügen", image: Image(systemName: "photo"))
                    .background(.white)
            }
        }, trailingAction: trailingAction)
    }
}

struct RecipeEditContentSectionView_Previews: PreviewProvider {
    @State static var content = [RecipeContentModel(type: .description(descriptionText: "Test"))]
    static var previews: some View {
        RecipeEditContentSectionView(title: "Titel", recipeContent: $content)
    }
}

