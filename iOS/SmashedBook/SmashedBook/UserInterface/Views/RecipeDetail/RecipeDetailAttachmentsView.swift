//
//  RecipeDetailAttachmentsView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentsView: View {
    @Binding var attachments: [ImageResourceModel]
    var didTapShowAttachment: ((ImageResourceModel) -> Void)?
    
    var body: some View {
        ListSectionView(title: "Anhänge") {
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
                .padding(.leading, LayoutConstants.safeAreaSpacing)
            }
            .listRowInsets(.init(top: LayoutConstants.verticalSpacing/2, leading: 0, bottom: LayoutConstants.verticalSpacing/2, trailing: 0))
        }
    }
}

#Preview {
    RecipeDetailAttachmentsView(attachments: .constant([]))
}
