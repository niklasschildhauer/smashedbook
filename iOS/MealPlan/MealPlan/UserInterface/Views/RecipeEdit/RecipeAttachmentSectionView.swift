//
//  RecipeAttachmentSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import SwiftUI

struct RecipeEditAttachmentSectionView: View {
    @Binding var attachments: [RecipeAttachmentModel]
    var didTapAddAttachment: () -> Void
    
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
            Button(action: {
                didTapAddAttachment()
            }, label: {
                IconLabelListCellView(title: "Anhang hinzufügen", image: Image(systemName: "plus"))
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

