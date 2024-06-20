//
//  RecipeNameLabelView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct RecipeEditNameSectionView: View {
    @Binding var name: String
    
    var body: some View {
        ListSectionView {
            TextField(text: $name) {
                Text("Rezeptname")
                    .font(.largeTitle)
            }
            .uiTestIdentifier("recipeNameInput")
            .font(.largeTitle)
        }
    }
}

struct RecipeEditNameLabelView_Previews: PreviewProvider {
    @State static var name = "Rezeptname"
    static var previews: some View {
        RecipeEditNameSectionView(name: RecipeEditNameLabelView_Previews.$name)
    }
}
