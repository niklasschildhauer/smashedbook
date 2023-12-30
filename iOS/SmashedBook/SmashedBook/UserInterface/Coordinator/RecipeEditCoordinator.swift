//
//  RecipeEditCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 05.10.23.
//

import SwiftUI

@Observable class RecipeEditCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = RecipeEditCoordinatorView
    
    var rootView: RecipeEditCoordinatorView {
        RecipeEditCoordinatorView(coordinator: self)
    }
    
    var recipeModel: RecipeModel {
        didSet {
            isRecipeEdited = true
        }
    }
    var validateErrorMessage: String?
    var addImageCoordinator: RecipeAddImageCoordinator? = nil
    // TODO: how to avoid this overhead of saving the recipe twice?
    var didEditRecipeModel: ((RecipeModel) -> Void)?
    var isRecipeEdited = false
    
    private var attachmentDataSource = FileSystemAttachmentDataSource()
    
    init(recipeModel: RecipeModel, onSaveRecipe: ((RecipeModel) -> Void)? = nil) {
        self._recipeModel = recipeModel
        self.didEditRecipeModel = onSaveRecipe
    }
    
    func start() { }
    
    func save() async {
        if isRecipeValid() {
            // TODO: It does not reset the binded value!
            didEditRecipeModel?(recipeModel)
        } else {
            // TODO: Handle this!
            print("I am not gonna save it!")
        }
    }
    
    // TODO: Outsource to recipeValidator
    func isRecipeValid() -> Bool {
        guard recipeModel.title != "" else {
            validateErrorMessage = "Rezeptname nicht ausgefüllt"
            return false
        }
        
        guard recipeModel.metaInformation.energy != nil else {
            validateErrorMessage = "Kalorien ausfüllen"
            return false
        }
        
        validateErrorMessage = ""
        return true
    }
    
    func addNewAttachmentData(data: [Data]) {
        recipeModel.attachments.append(contentsOf: data.compactMap { attachmentData in
            attachmentDataSource.save(attachmentData: attachmentData)
        })
        addImageCoordinator = nil
    }
    
    func addNewTitleImage(data: Data) {
        print(data.count)
        addImageCoordinator = nil
    }
}

struct RecipeEditCoordinatorView: View {
    @State var coordinator: RecipeEditCoordinator
    
    var body: some View {
        RecipeEditView(recipe: $coordinator.recipeModel,
                       didTapAddAttachment: {
            coordinator.addImageCoordinator = RecipeAddImageCoordinator(selectionCount: .multiple, didAddImageData: coordinator.addNewAttachmentData)
        }, didTapSelectTitleImage: {
            coordinator.addImageCoordinator = RecipeAddImageCoordinator(selectionCount: .one, didAddImageData: { data in
                if let data = data.first {
                    coordinator.addNewTitleImage(data: data)
                }
            })
        })
        .uiTestIdentifier("recipeEditCoordinator")
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern") {
                Task {
                    await coordinator.save()
                }
            }
        }
        .onAppear {
            coordinator.start()
        }
        .sheet(item: $coordinator.addImageCoordinator) { coordinator in
            coordinator.rootView
        }
        .interactiveDismissDisabled(coordinator.isRecipeEdited)
        .scrollDismissesKeyboard(.interactively)
        // TODO: Does this work?
    }
}

#Preview {
    RecipeEditCoordinatorView(coordinator: .init(recipeModel: recipeModelMock))
}
