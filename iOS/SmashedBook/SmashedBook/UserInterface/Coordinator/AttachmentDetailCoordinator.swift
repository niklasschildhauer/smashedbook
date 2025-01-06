//
//  AttachmentDetailCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 29.11.24.
//

import SwiftUI

@Observable class AttachmentDetailCoordinator: SwiftUICoordinator, Identifiable {
    typealias CoordinatorView = AttachmentDetailCoordinatorView
    
    var rootView: AttachmentDetailCoordinatorView {
        AttachmentDetailCoordinatorView(coordinator: self)
    }
    
    var imageResourceModel: ImageResourceModel
    
    init(imageResourceModel: ImageResourceModel) {
        self.imageResourceModel = imageResourceModel
    }

}

struct AttachmentDetailCoordinatorView: View {
    @State var coordinator: AttachmentDetailCoordinator
    
    var body: some View {
        ZoomableScrollView {
            ImageResourceView(imageResource: $coordinator.imageResourceModel)
        }
    }
}
