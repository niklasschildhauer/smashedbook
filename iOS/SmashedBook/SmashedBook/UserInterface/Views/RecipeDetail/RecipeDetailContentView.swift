//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Binding var recipe: RecipeModel
    
    var didTapShowAttachment: ((RecipeAttachmentModel) -> Void)? = nil
    
    var body: some View {
        List {
            ParallaxHeader() {
                Image("ExamplePicture")
                    .resizable()
                    .scaledToFill()
            } bottomView: {
                Text("Test")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        
            RecipeDetailMetainformationView(metainformation: recipe.metaInformation)
                .padding(.vertical, 10)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: LayoutConstants.verticalSpacing, leading: LayoutConstants.safeAreaSpacing, bottom: LayoutConstants.verticalSpacing, trailing: LayoutConstants.safeAreaSpacing))
            ForEach(0..<5) { _ in
                Text("Das ist ein Test")
                    .listRowInsets(.init(top: LayoutConstants.verticalSpacing, leading: LayoutConstants.safeAreaSpacing, bottom: LayoutConstants.verticalSpacing, trailing: LayoutConstants.safeAreaSpacing))
            }
            RecipeDetailAttachmentsView(attachments: $recipe.attachments) { attachment in
                didTapShowAttachment?(attachment)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

        }
        .edgesIgnoringSafeArea(.top) // TODO: With or without? It looks nicer without this value...
        .listStyle(.plain)
        
    }
}

#Preview {
    RecipeDetailContentView(recipe: .constant(recipeModelMock))
}

