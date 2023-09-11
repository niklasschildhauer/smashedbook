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
    @State var presentAddContent = false
    var trailingAction: () -> TrailingAction
    @Binding var content: [RecipeContent]
    
    init(title: String, content: Binding<[RecipeContent]>,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = {EmptyView()}) {
        self.title = title
        self._content = content
        self.trailingAction = trailingAction
    }
    
    var body: some View {
        ListSectionView(title: title, content: {
            ScrollViewReader { value in
                ForEach(content, id: \.id) { item in
                    EditRecipeImageListCellView(image: Image("ExampleRecipe"))
                    Divider()
                }
            }
            Button {
                print("Open the view to select an image and save it in the array above!")
                presentAddContent.toggle()
                withAnimation {
                    content.append(RecipeContent(type: .description(descriptionText: "Das ist ein Test")))
                    //content.append(.init())
                }
            } label: {
                IconLabelListCellView(title: "Foto hinzufügen", image: Image(systemName: "photo"))
                    .background(.white)
            }
        }, trailingAction: trailingAction)
        .sheet(isPresented: $presentAddContent, content: {
            AddRecipeContentPageView()
        })
    }
}

struct EditRecipeContentSectionView_Previews: PreviewProvider {
    @State static var content = [RecipeContent(type: .description(descriptionText: "Test"))]
    static var previews: some View {
        EditRecipeContentSectionView(title: "Titel", content: $content)
    }
}

