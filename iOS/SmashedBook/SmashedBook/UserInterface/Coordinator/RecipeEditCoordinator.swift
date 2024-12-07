//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

protocol RecipeEditView<EditModel>: View {
    associatedtype EditModel
    var coordinator: RecipeEditCoordinator<EditModel, Self> { get set }
 
    init(coordinator: RecipeEditCoordinator<EditModel, Self>)
}

@Observable class RecipeEditCoordinator<EditModel, EditView>: SwiftUICoordinator, Identifiable where EditView: RecipeEditView<EditModel> {
    typealias CoordinatorView = EditView
    var rootView: EditView {
        EditView(coordinator: self)
    }
    
    var editModel: EditModel
    var onSave: (EditModel) -> Void
            
    init(editModel: EditModel,
         onSave: @escaping (EditModel) -> Void) {
        self.editModel = editModel
        self.onSave = onSave
    }
    
    func start() { }
    
    func save() {
        onSave(editModel)
    }
}

struct RecipeEditCoordinatorView: RecipeEditView {
    typealias EditModel = RecipeStepModel
    typealias EditView = RecipeEditCoordinatorView
    
    @State var coordinator: RecipeEditCoordinator<RecipeStepModel, RecipeEditCoordinatorView>
    
    var body: some View {
        NavigationStack {
            RecipeEditStepView(description: $coordinator.editModel.description)
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
    RecipeEditCoordinatorView(coordinator: RecipeEditCoordinator(editModel: .init(description: "Test"), onSave: { _ in
        print("Did save")
    }))
}
