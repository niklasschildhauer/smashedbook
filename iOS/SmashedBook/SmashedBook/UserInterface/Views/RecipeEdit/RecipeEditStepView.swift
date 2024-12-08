//
//  RecipeEditStepView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.08.24.
//

import SwiftUI

enum RecipeEditStepFocus {
    case descriptionField
}

struct RecipeEditStepCoordinatorView: RecipeEditView {
    typealias EditModel = RecipeStepModel
    typealias EditView = Self
    
    @State var coordinator: RecipeEditCoordinator<RecipeStepModel, Self>
        
    var body: some View {
        NavigationStack {
            RecipeEditStepView(description: $coordinator.editModel.description)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Fertig") {
                            coordinator.save()
                        }
                    }
                }
        }
    }
}

#Preview {
    RecipeEditStepCoordinatorView(coordinator: RecipeEditCoordinator(editModel: .init(description: "Test"), onSave: { _ in
        print("Did save")
    }))
}


struct RecipeEditStepView: View {
    @Binding var description: String
    @FocusState var focusedField: RecipeEditStepFocus?

    var body: some View {
        VStack {
            TextEditorWithPlaceholder(text: $description, placeholder: .constant("Beschreibe den Rezeptschritt"))
                .focused($focusedField, equals: .descriptionField)
            Spacer(minLength: LayoutConstants.verticalSpacing)
        }
        .padding(.horizontal, LayoutConstants.safeAreaSpacing)
        .onAppear {
            focusedField = .descriptionField
        }
    }
}

