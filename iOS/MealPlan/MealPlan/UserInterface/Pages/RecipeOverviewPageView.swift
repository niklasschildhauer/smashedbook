//
//  RecipeOverviewPage.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeOverviewPageView: View {
    @State var showAddRecipePageView = false
    var body: some View {
        RecipeListingView()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    LabelButtonView(viewModel: .create(action: {
                        showAddRecipePageView.toggle()
                    },
                                                       title: "Hinzufügen",
                                                       type: .primary))
                    .uiTestIdentifier("addRecipeButton")
                })
            }
            .navigationTitle("Meine Rezepte")
            .sheet(isPresented: $showAddRecipePageView) {
                AddRecipePageView()
            }
    }
}

#Preview {
    RecipeOverviewPageView()
}
