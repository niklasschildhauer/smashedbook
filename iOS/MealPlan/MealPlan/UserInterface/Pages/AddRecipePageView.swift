//
//  AddRecipePageView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct AddRecipePageView: View {
    var body: some View {
        NavigationStack {
            EditRecipeView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        LabelButtonView(viewModel: .create(action: {},
                                                           title: "Hinzufügen",
                                                           type: .primary))
                    })
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        LabelButtonView(viewModel: .create(action: {},
                                                           title: "Abbrechen",
                                                           type: .cancel))
                    })
                }.background(Colors.backgroundColor)
        }
    }
}

struct AddRecipePageView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipePageView()
    }
}
