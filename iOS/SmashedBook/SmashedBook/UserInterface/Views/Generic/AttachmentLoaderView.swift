//
//  AttachmentLoaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import SwiftUI

struct AttachmentLoaderView: View  {
    @Binding var attachment: ImageResourceModel?
    
    private let attachmentDataSource = FileSystemAttachmentDataSource()
    
    var body: some View {
        if let attachment,
           let image = image(from: attachment) {
            image
                .resizable()
                .scaledToFit()
        }
    }
    
    private func image(from attachment: ImageResourceModel) -> Image? {
        guard let data = attachmentDataSource.load(attachment: attachment),
              let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    AttachmentLoaderView(attachment: .constant(.init(fileName: UUID().uuidString)))
}
