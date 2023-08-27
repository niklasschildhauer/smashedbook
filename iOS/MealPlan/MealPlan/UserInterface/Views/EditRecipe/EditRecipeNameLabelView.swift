//
//  RecipeNameLabelView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct EditRecipeNameLabelView: View {
    @State var name = ""
    
    var body: some View {
        TextField(text: $name) {
            Text("Rezeptname")
                .font(.largeTitle)
        }.font(.largeTitle)
    }
}

struct EditRecipeNameLabelView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeNameLabelView()
    }
}
