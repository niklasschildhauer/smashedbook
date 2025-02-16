//
//  RecipeDetailAttachmentsView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

protocol RecipeDetailAttachmentDelegate: ObservableObject  {
    func addImage()
    func showAttachment(attachment: ImageResourceModel)
}

struct RecipeDetailAttachmentsView<Coordinator>: View where Coordinator: RecipeDetailAttachmentDelegate {
    @Environment(\.editMode) var editMode
    @Binding var attachments: [ImageResourceModel]
    @EnvironmentObject var coordinator:  Coordinator

    var isEditedModeActive: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        ListSectionView(title: "Anhänge", content: {
            if $attachments.isEmpty {
                Text("Keine Anhänge verfügbar")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: LayoutConstants.horizontalSpacing) {
                        ForEach($attachments) { attachment in
                            ZStack(alignment: .topLeading) {
                                Button {
                                    coordinator.showAttachment(attachment: attachment.wrappedValue)
                                } label: {
                                    RecipeDetailAttachmentCellView(attachment: attachment)
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
            }
        }, trailingAction: {
            Button {
                coordinator.addImage()
            } label: {
                Text("Hinzufügen")
                    .font(.footnote)
            }
        })
    }
    
    func deleteAttachment(attachment: ImageResourceModel) {
        // todo: also remove the attachment from the cache
        withAnimation {
            attachments.removeAll{ $0.id == attachment.id }
        }
    }
}
