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
    var didTapDone: () -> Void
    
    init(imageResourceModel: ImageResourceModel,
         didTapDone: @escaping () -> Void) {
        self.imageResourceModel = imageResourceModel
        self.didTapDone = didTapDone
    }

}

struct AttachmentDetailCoordinatorView: View {
    @State var coordinator: AttachmentDetailCoordinator
    
    var body: some View {
        NavigationStack {
            ZoomableScrollView {
                Image.createImageFrom(imageResource: $coordinator.wrappedValue.imageResourceModel)
                    .resizable()
                    .scaledToFit()
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.didTapDone()
                    } label: {
                        Text("Fertig")
                    }
                    
                }
            })
        }
        .interactiveDismissDisabled()
        .ignoresSafeArea()
        .colorScheme(.dark)
    }
}

#Preview {
    AttachmentDetailCoordinatorView(coordinator: .init(imageResourceModel: ImageResourceModel(fileName: ""), didTapDone: {
        print("Done")
    }))
}
