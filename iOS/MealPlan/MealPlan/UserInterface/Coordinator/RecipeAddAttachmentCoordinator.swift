//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI
import Photos

@Observable class RecipeAddAttachmentCoordinator: Coordinator, Identifiable {
    typealias CoordinatorView = RecipeAddAttachmentCoordinatorView
    
    var rootView: RecipeAddAttachmentCoordinatorView {
        RecipeAddAttachmentCoordinatorView(coordinator: self)
    }
    
    var didAddRecipeAttachment: ([RecipeAttachmentModel]) -> Void
    var selectedImageData: [Data] = []
    
    private let attachmentDataSource = FileSystemAttachmentDataSource()
    
    init(didAddRecipeAttachment: @escaping ([RecipeAttachmentModel]) -> Void) {
        self.didAddRecipeAttachment = didAddRecipeAttachment
    }
    
    // TODO: do i need the start method?
    func start() { }
    
    fileprivate func didTapSave() {
        let newRecipeAttachments = selectedImageData.compactMap { imageData in
            attachmentDataSource.save(attachmentData: imageData)
        }
        
        didAddRecipeAttachment(newRecipeAttachments)
    }
}

struct RecipeAddAttachmentCoordinatorView: View {
    @State var coordinator: RecipeAddAttachmentCoordinator
    
    var body: some View {
        ImagePicker(selectedImageData: $coordinator.selectedImageData)
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern") {
                coordinator.didTapSave()
            }
        }
    }
}
