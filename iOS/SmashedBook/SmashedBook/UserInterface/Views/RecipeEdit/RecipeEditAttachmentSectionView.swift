//
//  RecipeAttachmentSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import SwiftUI

struct RecipeEditAttachmentSectionView: View {
    @Binding var attachments: [RecipeAttachmentModel]
    @Binding var addAttachmentCoordinator: RecipeAddImageCoordinator?
    
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
                addAttachmentCoordinator = RecipeAddImageCoordinator(didAddRecipeAttachments: { attachments in
                    self.attachments.append(contentsOf: attachments)
                    addAttachmentCoordinator = nil
                })
            }, label: {
                Text("Hinzufügen")
            })
        })
    }
    
    private func image(from attachment: RecipeAttachmentModel) -> Image? {
        guard let data = attachmentDataSource.load(attachment: attachment),
              let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

