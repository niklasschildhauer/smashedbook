//
//  RecipeDetailAttachmentsView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentsView: View {
    @Binding var attachments: [RecipeAttachmentModel]
    var didTapShowAttachment: ((RecipeAttachmentModel) -> Void)?
    
    var body: some View {
        SectionView(title: "Anhänge") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    ForEach($attachments) { attachment in
                        Button {
                            didTapShowAttachment?(attachment.wrappedValue)
                        } label: {
                            RecipeDetailAttachmentImageView(attachment: attachment)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeDetailAttachmentsView(attachments: .constant([]))
}
