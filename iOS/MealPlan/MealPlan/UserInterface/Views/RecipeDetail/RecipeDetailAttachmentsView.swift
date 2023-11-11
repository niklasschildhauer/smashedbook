//
//  RecipeDetailAttachmentsView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentsView: View {
    @Binding var attachments: [RecipeAttachmentModel]
    
    private static let attachmentHeight = 220.0
    private static let attachmentWidth = 125.0
    
    var body: some View {
        SectionView(title: "Anhänge") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    ForEach($attachments) { attachment in
                        RecipeDetailAttachmentImageView(attachment: attachment)
                            .frame(width: RecipeDetailAttachmentsView.attachmentWidth, height: RecipeDetailAttachmentsView.attachmentHeight)
                            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeDetailAttachmentsView(attachments: .constant([]))
}
