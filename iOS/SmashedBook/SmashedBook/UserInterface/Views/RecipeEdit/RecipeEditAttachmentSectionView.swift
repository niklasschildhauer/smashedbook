//
//  RecipeAttachmentSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import SwiftUI

struct RecipeEditAttachmentSectionView: View {
    @Binding var attachments: [ImageResourceModel]
    @Binding var addImageCoordinator: AddImageCoordinator?
    private let attachmentDataSource = FileSystemAttachmentDataSource()
    
    var body: some View {
        ListSectionView(title: "Anhänge", content: {
            ForEach($attachments.wrappedValue) { attachment in
                if let image = image(from: attachment) {
                    RecipeEditAttachmentPreviewListCellView(attachmentPreviewImage: image)
                } else {
                    Text("Image could not be loaded")
                }
            }
            .onDelete { indexSet in
                attachments.remove(atOffsets: indexSet)
            }
        }, trailingAction: {
            Button(action: {
                addImageCoordinator = AddImageCoordinator(didAddImageResources: { attachments in
                    self.attachments.append(contentsOf: attachments)
                    addImageCoordinator = nil
                })
            }, label: {
                Text("Hinzufügen")
            })
        })
    }
    
    private func image(from attachment: ImageResourceModel) -> Image? {
        guard let data = attachmentDataSource.load(attachment: attachment),
              let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

