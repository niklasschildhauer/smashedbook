//
//  RecipeEditTitleImageSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 12.11.23.
//

import SwiftUI

struct RecipeEditTitleImageSectionView: View {
    @Binding var addAttachmentCoordinator: RecipeAddImageCoordinator?
    @State var titleImage: RecipeAttachmentModel?
    
    var body: some View {
        AttachmentLoaderView(attachment: $titleImage)
        Button(action: {
            addAttachmentCoordinator = RecipeAddImageCoordinator(selectionCount: .one, didAddRecipeAttachments: { attachments in
                titleImage = attachments.first
                addAttachmentCoordinator = nil
            })
        }, label: {
            IconLabelListCellView(title: "Bild auswählen", image: Image(systemName: "plus"))
        })
    }
}

#Preview {
    RecipeEditTitleImageSectionView(addAttachmentCoordinator: .constant(nil))
}
