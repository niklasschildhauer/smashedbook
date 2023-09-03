//
//  EditRecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

class EditRecipeViewModel: ObservableObject {
    @Published var recipeName: String = ""
    
    func createRecipeModel() {
        print("Create Recipe Model")
    }
}


struct EditRecipeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: LayoutConstants.verticalPadding) {
                EditRecipeNameLabelView()
                EditRecipeMetaInformationSectionView()
                EditRecipeContentSectionView(title: "Zutaten") {
                    EditRecipePortionCounterView()
                }
                EditRecipeContentSectionView(title: "Anleitung")
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
            .padding(.vertical, LayoutConstants.verticalPadding)
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView()
    }
}
