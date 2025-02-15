//
//  RecipeDetailIngredientsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeEditIngredientsCoordinatorView: RecipeEditView {
    typealias EditModel = RecipeIngredientModel
    
    @State var coordinator: RecipeEditCoordinator<Self>

    var body: some View {
        NavigationStack {
            RecipeEditIngredientsView(editModel: $coordinator.editModel)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        coordinator.save()
                    }
                }
            }
            .navigationTitle("Zutat")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
        }
    }
}


#Preview {
    RecipeEditIngredientsCoordinatorView(coordinator: RecipeEditCoordinator(editModel: .init(name: "Name", value: "Value", unit: .kilogram), onSave: { _ in
        print("Did save")
    }))
}

struct RecipeEditIngredientsView: View {
    @Binding var editModel: RecipeIngredientModel
    
    var body: some View {
        List {
            HStack {
                Text("Name")
                Spacer()
                TextField("Zutat", text: $editModel.name)
                    .multilineTextAlignment(.trailing)
                    .bold()
            }
            Section {
                HStack {
                    Text("Menge")
                    Spacer()
                    TextField("0.0", text: $editModel.value)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.trailing)
                        .bold()
                }
                Picker("Einheit", selection: $editModel.unit) {
                    ForEach(RecipeIngredientUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}
