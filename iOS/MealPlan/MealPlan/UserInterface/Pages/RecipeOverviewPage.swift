//
//  RecipeOverviewPage.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeOverviewPage: View {
    @State var showAddRecipePageView = false
    
    var body: some View {
        NavigationStack {
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
        .uiTestIdentifier("recipeOverviewPageView")
    }
}

struct RecipeOverviewPage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeOverviewPage()
    }
}
