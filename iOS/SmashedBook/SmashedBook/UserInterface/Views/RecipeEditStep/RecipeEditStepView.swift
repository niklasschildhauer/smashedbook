//
//  RecipeEditStepView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.08.24.
//

import SwiftUI

struct RecipeEditStepView: View {
    
    @State var recipeStep: RecipeStepModel
    var onSave: (RecipeStepModel) -> Void
    
    var body: some View {
        VStack {
            TextEditor(text: $recipeStep.description)
                .multilineTextAlignment(.leading)
                .fill(.height, alignment: .top)
                .fill(.width, alignment: .leading)
            
            IconLabelFilledButtonView(title: "Speichern", iconSystemName: "trash.fill") {
                onSave(recipeStep)
            }
        }
        .padding(LayoutConstants.safeAreaSpacing)
    }
}

#Preview {
    RecipeEditStepView(recipeStep: .init(description: "Test")) { stepModel in
        print("save it")
    }
}
