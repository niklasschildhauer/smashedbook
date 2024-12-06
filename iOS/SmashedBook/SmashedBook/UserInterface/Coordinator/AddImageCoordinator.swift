//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI
import Photos
import PDFKit


@Observable class AddImageCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = AddImageCoordinatorView
    
    enum SelctionCount {
        case multiple
        case one
    }
    
    var rootView: AddImageCoordinatorView {
        AddImageCoordinatorView(coordinator: self)
    }
    
    var didAddImageResources: ([ImageResourceModel]) -> Void
    private let selectionCount: SelctionCount
    fileprivate var selectedData: [Data] = []
    private let resourcesDataSource: ResourcesDataSource
    
    var maxSelection: Int {
        switch selectionCount {
        case .multiple:
            10
        case .one:
            1
        }
    }
    
    init(selectionCount: SelctionCount = .multiple,
         didAddImageResources: @escaping ([ImageResourceModel]) -> Void,
         resourcesDataSource: ResourcesDataSource = FileSystemAttachmentDataSource()) {
        self.selectionCount = selectionCount
        self.didAddImageResources = didAddImageResources
        self.resourcesDataSource = resourcesDataSource
    }
    
    func start() { }
    
    fileprivate func didTapSave() {
        let imageResources = selectedData.compactMap { data in
            resourcesDataSource.save(attachmentData: data)
        }
        didAddImageResources(imageResources)
    }
}

struct AddImageCoordinatorView: View {
    @State var coordinator: AddImageCoordinator
    
    var body: some View {
        ImagePicker(selectionCount: coordinator.maxSelection, selectedImageData: $coordinator.selectedData)
            .fill(.height)
        .bottomToolbar {
            IconLabelFilledButtonView(title: "Speichern", iconSystemName: "trash.fill") {
                coordinator.didTapSave()
            }
        }
    }
}
