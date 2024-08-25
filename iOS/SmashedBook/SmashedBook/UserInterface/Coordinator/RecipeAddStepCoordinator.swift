//
//  RecipeAddStepCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.05.24.
//

import Foundation
import SwiftUI

@Observable class RecipeAddStepCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = RecipeAddStepCoordinatorView
    
    var rootView: RecipeAddStepCoordinatorView {
        RecipeAddStepCoordinatorView(coordinator: self)
    }
    
    var text: String = ""
    var onSaveRecipe: (([RecipeStepModel])  -> Void)?
    
    init(onSaveSteps: (([RecipeStepModel])  -> Void)) {
        self.onSaveRecipe = onSaveRecipe
    }
    
    func save() {
        print("convert the text to recipe steps")
    }
}

struct RecipeAddStepCoordinatorView: View {
    @State var coordinator: RecipeAddStepCoordinator
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextEditor(text: $coordinator.text)
            .focused($isFocused)
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern", iconSystemName: "trash.fill") {
                coordinator.save()
            }
        }
        .onAppear {
            isFocused = true
        }
        .presentationDetents(Set(arrayLiteral: PresentationDetent.fraction(0.3)))
    }
}
