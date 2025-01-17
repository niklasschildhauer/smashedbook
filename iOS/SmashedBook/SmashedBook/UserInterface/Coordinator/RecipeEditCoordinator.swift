//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

protocol RecipeEditView<EditModel>: View {
    associatedtype EditModel
    var coordinator: RecipeEditCoordinator<Self> { get set }
 
    init(coordinator: RecipeEditCoordinator<Self>)
}

@Observable class RecipeEditCoordinator<EditView>: SwiftUICoordinator, Identifiable where EditView: RecipeEditView<EditView.EditModel> {
    typealias CoordinatorView = EditView
    var rootView: EditView {
        EditView(coordinator: self)
    }
    
    var editModel: EditView.EditModel
    var onSave: (EditView.EditModel) -> Void
            
    init(editModel: EditView.EditModel,
         onSave: @escaping (EditView.EditModel) -> Void) {
        self.editModel = editModel
        self.onSave = onSave
    }
    
    func start() { }
    
    func save() {
        onSave(editModel)
    }
}

