//
//  RecipeDetailAttachmentsView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentsView: View {
    @Binding var attachments: [ImageResourceModel]
    @Environment(\.editMode) var editMode
    
    var isEditedModeActive: Bool {
        editMode?.wrappedValue == .active
    }
    // todo no function -> Binding!
    var didTapShowAttachment: ((ImageResourceModel) -> Void)?
    var addAttachment: (() -> Void)?
    
    var body: some View {
        ListSectionView(title: "Anhänge", content: {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    ForEach($attachments) { attachment in
                        ZStack(alignment: .topLeading) {
                            Button {
                                didTapShowAttachment?(attachment.wrappedValue)
                            } label: {
                                RecipeDetailAttachmentImageView(attachment: attachment)
                            }
                            .disabled(isEditedModeActive)
                            if isEditedModeActive {
                                Button {
                                    deleteAttachment(attachment: attachment.wrappedValue)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .imageScale(.large)
                                        .foregroundStyle(.red)
                                }
                                .offset(x: 10, y: 10)
                            }
                        }
                    }
                }
                .padding(.horizontal, LayoutConstants.safeAreaSpacing)

            }
            .listRowInsets(.init(top: LayoutConstants.verticalSpacing/2, leading: 0, bottom: LayoutConstants.verticalSpacing/2, trailing: 0))
        }, trailingAction: {
            Button {
                addAttachment?()
            } label: {
                Text("Hinzufügen").font(.footnote)
            }
        })
    }
    
    func deleteAttachment(attachment: ImageResourceModel) {
        // todo: also remove the attachment from the cache
        // todo: fix animation
        withAnimation {
            attachments.removeAll { attach in
                attachment.id == attach.id
            }
        }

    }
}

#Preview {
    RecipeDetailAttachmentsView(attachments: .constant([]))
}
