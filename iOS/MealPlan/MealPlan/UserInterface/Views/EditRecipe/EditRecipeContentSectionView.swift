//
//  EditRecipeIngredientsSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

protocol EditRecipeContent: Identifiable {
    var id: UUID { get }
}

extension EditRecipeContent {
    var id: UUID {
        UUID()
    }
}

struct EditRecipeContentSectionView<TrailingAction: View>: View {
    var title: String
    var trailingAction: () -> TrailingAction
    @State var presentAddContent = false
    @Binding var recipeContent: [RecipeContent]
    
    init(title: String, recipeContent: Binding<[RecipeContent]>,
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
                    EditRecipeDescriptionListCellView(description: descriptionText, onEdit: { editedDescription in
                        guard let index = recipeContent.firstIndex(of: item.wrappedValue) else {
                            return
                        }
                        recipeContent[index].type = .description(descriptionText: editedDescription)
                    })
                case .image(let imageUrl):
                    EditRecipeImageListCellView(image: Image("ExampleRecipe"))
                    
                }
                Divider()
            }
            
            Button {
                presentAddContent.toggle()
                withAnimation {
                    recipeContent.append(RecipeContent(type: .description(descriptionText: "Das ist ein Test")))
                    //content.append(.init())
                }
            } label: {
                IconLabelListCellView(title: "Foto hinzufügen", image: Image(systemName: "photo"))
                    .background(.white)
            }
        }, trailingAction: trailingAction)
        .sheet(isPresented: $presentAddContent, content: {
            AddRecipeContentPageView()
                .presentationDetents([.medium, .large])
        })
    }
}

struct EditRecipeContentSectionView_Previews: PreviewProvider {
    @State static var content = [RecipeContent(type: .description(descriptionText: "Test"))]
    static var previews: some View {
        EditRecipeContentSectionView(title: "Titel", recipeContent: $content)
    }
}

