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

