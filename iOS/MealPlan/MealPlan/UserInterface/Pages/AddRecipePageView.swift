//
//  AddRecipePageView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct AddRecipePageView: View {
    @State var editRecipeViewModel = EditRecipeViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            EditRecipeView(recipe: $editRecipeViewModel.recipe)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        LabelButtonView(viewModel: .create(action: {
                            editRecipeViewModel.save()
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
