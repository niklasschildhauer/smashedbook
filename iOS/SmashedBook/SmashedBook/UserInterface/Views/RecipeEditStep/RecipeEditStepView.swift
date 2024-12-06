//
//  RecipeEditStepView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.08.24.
//

import SwiftUI

struct RecipeEditStepView: View {
    @Binding var description: String
    
    var body: some View {
        VStack {
            TextEditorWithPlaceholder(text: $description, placeholder: .constant("Beschreibe den Rezeptschritt"))
            Spacer(minLength: LayoutConstants.verticalSpacing)
        }
        .padding(LayoutConstants.safeAreaSpacing)
    }
}

#Preview {
    RecipeEditStepView(description: .constant("Test"))
}
