//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView<Coordinator>: View where Coordinator: RecipeDetailCoordinating {
    @Binding var recipe: RecipeModel
    @Environment(\.editMode) var editMode
    @EnvironmentObject var coordinator:  Coordinator
    
    var isEditModeActive: Bool {
        editMode?.wrappedValue == .active
    }
        
    var body: some View {
        List {
            if isEditModeActive {
                Image.createImageFrom(imageResource: $recipe.titleImage.wrappedValue)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(Circle())
                    .listRowSeparator(.hidden)
//                    .overlay(alignment: .bottomTrailing) {
//                        Button {
//                            print("Test")
//                        } label: {
//                            Text("Test")
//                        }
//                    }
                    .selectionDisabled()
                TextField("Rezeptname", text: $recipe.title)
                    .multilineTextAlignment(.center)
                    .font(.GeistMedium, fontStyle: .largeTitle)
                    .listRowSeparator(.hidden)
            } else {
                RecipeDetailHeaderView<Coordinator>(title: $recipe.title, titleImage: $recipe.titleImage)
            }
            RecipeDetailIngredientsView<Coordinator>(ingredients: $recipe.ingredients)
            RecipeDetailStepsView<Coordinator>(steps: $recipe.steps)
            RecipeDetailAttachmentsView<Coordinator>(attachments: $recipe.attachments)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RecipeDetailView<RecipeDetailCoordinator>(recipe: .constant(recipeModelMock))
        .environment(RecipeDetailCoordinator(recipeModel: recipeModelMock))
        .environment(\.editMode, Binding.constant(EditMode.active))
}


