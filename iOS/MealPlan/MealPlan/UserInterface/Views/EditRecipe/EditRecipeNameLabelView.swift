//
//  RecipeNameLabelView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct EditRecipeNameLabelView: View {
    @Binding var name: String
    
    var body: some View {
        TextField(text: $name) {
            Text("Rezeptname")
                .font(.largeTitle)
        }
        .uiTestIdentifier("recipeNameInput")
        .font(.largeTitle)
    }
}

struct EditRecipeNameLabelView_Previews: PreviewProvider {
    @State static var name = "Rezeptname"
    static var previews: some View {
        EditRecipeNameLabelView(name: EditRecipeNameLabelView_Previews.$name)
    }
}
