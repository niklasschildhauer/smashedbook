//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI
import Photos
import PDFKit


@Observable class RecipeAddImageCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = RecipeAddImageCoordinatorView
    
    enum SelctionCount {
        case multiple
        case one
    }
    
    var rootView: RecipeAddImageCoordinatorView {
        RecipeAddImageCoordinatorView(coordinator: self)
    }
    
    var didAddRecipeAttachments: ([RecipeAttachmentModel]) -> Void
    private let selectionCount: SelctionCount
    fileprivate var selectedData: [Data] = []
    private let attachmentDataSource: AttachmentDataSource
    
    var maxSelection: Int {
        switch selectionCount {
        case .multiple:
            10
        case .one:
            1
        }
    }
    
    init(selectionCount: SelctionCount = .multiple,
         didAddRecipeAttachments: @escaping ([RecipeAttachmentModel]) -> Void,
         attachmentDataSource: AttachmentDataSource = FileSystemAttachmentDataSource()) {
        self.selectionCount = selectionCount
        self.didAddRecipeAttachments = didAddRecipeAttachments
        self.attachmentDataSource = attachmentDataSource
    }
    
    // TODO: do i need the start method?
    func start() { }
    
    fileprivate func didTapSave() {
        let recipeAttachments = selectedData.compactMap { data in
            attachmentDataSource.save(attachmentData: data)
        }
        didAddRecipeAttachments(recipeAttachments)
    }
}

struct RecipeAddImageCoordinatorView: View {
    @State var coordinator: RecipeAddImageCoordinator
    
    var body: some View {
        ImagePicker(selectionCount: coordinator.maxSelection, selectedImageData: $coordinator.selectedData)
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern") {
                coordinator.didTapSave()
            }
        }
    }
}
