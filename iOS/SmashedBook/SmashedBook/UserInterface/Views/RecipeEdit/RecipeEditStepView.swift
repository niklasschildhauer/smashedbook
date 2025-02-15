//
//  RecipeEditStepView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.08.24.
//

import SwiftUI

struct RecipeEditStepCoordinatorView: RecipeEditView {
    typealias EditModel = RecipeStepModel
    
    @State var coordinator: RecipeEditCoordinator<Self>
        
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
                .navigationTitle("Rezeptschritt")
                .navigationBarTitleDisplayMode(.inline)
                .scrollDismissesKeyboard(.interactively)
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
    
    var body: some View {
        List {
            TextEditorWithPlaceholder(text: $description, placeholder: "Beschreibe den Rezeptschritt")
                .frame(minHeight: 200)
        }
    }
}

