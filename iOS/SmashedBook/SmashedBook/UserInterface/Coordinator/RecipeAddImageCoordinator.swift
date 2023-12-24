//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI
import Photos
import PDFKit

@Observable class RecipeAddImageCoordinator: Coordinator, Identifiable {    
    typealias CoordinatorView = RecipeAddImageCoordinatorView
    
    var rootView: RecipeAddImageCoordinatorView {
        RecipeAddImageCoordinatorView(coordinator: self)
    }
    
    var didAddImageData: ([Data]) -> Void
    var selectedData: [Data] = []
    
    enum SelctionCount {
        case multiple
        case one
    }
    
    private let selectionCount: SelctionCount
    
    var maxSelection: Int {
        switch selectionCount {
        case .multiple:
            10
        case .one:
            1
        }
    }
    
    init(selectionCount: SelctionCount = .multiple,
         didAddImageData: @escaping ([Data]) -> Void) {
        self.selectionCount = selectionCount
        self.didAddImageData = didAddImageData
    }
    
    // TODO: do i need the start method?
    func start() { }
    
    fileprivate func didTapSave() {
        didAddImageData(selectedData)
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
