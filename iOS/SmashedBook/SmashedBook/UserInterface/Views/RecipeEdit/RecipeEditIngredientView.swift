//
//  RecipeDetailIngredientsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeEditIngredientsCoordinatorView: RecipeEditView {
    typealias EditModel = RecipeIngredientModel
    typealias EditView = Self
    
    @State var coordinator: RecipeEditCoordinator<RecipeIngredientModel, Self>
    
    var body: some View {
        NavigationStack {
            RecipeEditIngredientView(ingredient: $coordinator.editModel)
                .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Save") {
                            coordinator.save()
                        }
                    }
                }
        }
    }
}

#Preview {
    RecipeEditIngredientsCoordinatorView(coordinator: RecipeEditCoordinator(editModel: .init(name: "Name", value: "Value", unit: .gram), onSave: { _ in
        print("Did save")
    }))
}

enum RecipeEditIngredientFocus {
    case nameField
    case valueField
}

struct RecipeEditIngredientView: View {
    @Binding var ingredient: RecipeIngredientModel
    
    @FocusState var focusedField: RecipeEditIngredientFocus?
        
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            TextField("Zutat", text: $ingredient.name)
                .focused($focusedField, equals: .nameField)
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                TextField("Menge", text: $ingredient.value)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 60)
                    .focused($focusedField, equals: .valueField)
                Picker("Einheit", selection: $ingredient.unit) {
                    ForEach(RecipeIngredientUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .fixedSize(horizontal: true, vertical: true)
            }
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(Color("shape")))
        }
        .onAppear {
            focusedField = .nameField
        }
    }
}
