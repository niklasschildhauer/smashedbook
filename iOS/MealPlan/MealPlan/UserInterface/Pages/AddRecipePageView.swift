//
//  AddRecipePageView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

@Observable class AddRecipePageViewModel {
    // add RecipeInteractor as Environment in here. Entweder als Dependency Injection oder als DIWrapper oder direkt als Environment. Je nachdem welcher Mechanismus besser funktioniert.
    let recipeInteractor = RecipeInteractor()
    var recipe = Recipe()
    
    func save() {
        print(recipe.title)
        print(recipe.ingredients)
    }
    
    static func create(from recipe: Recipe) -> AddRecipePageViewModel {
        let viewModel = AddRecipePageViewModel()
        viewModel.recipe = recipe
        
        return viewModel
    }
}

struct AddRecipePageView: View {
    @State var viewModel = AddRecipePageViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            EditRecipeView(recipe: $viewModel.recipe)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        LabelButtonView(viewModel: .create(action: {
                            viewModel.save()
                            presentationMode.wrappedValue.dismiss()
                        },
                                                           title: "Hinzufügen",
                                                           type: .primary))
                    })
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        LabelButtonView(viewModel: .create(action: {},
                                                           title: "Abbrechen",
                                                           type: .cancel))
                    })
                }
                .background(Colors.backgroundColor)
        }
        .uiTestIdentifier("addRecipePageView")
    }
}

struct AddRecipePageView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipePageView()
    }
}
