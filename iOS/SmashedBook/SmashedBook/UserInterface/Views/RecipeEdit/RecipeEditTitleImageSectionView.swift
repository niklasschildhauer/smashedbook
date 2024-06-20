//
//  RecipeEditTitleImageSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 12.11.23.
//

import SwiftUI

struct RecipeEditTitleImageSectionView: View {
    @Binding var addImageCoordinator: AddImageCoordinator?
    @Binding var titleImage: ImageResourceModel?
    
    var body: some View {
        AttachmentLoaderView(attachment: $titleImage)
            .frame(height: 200)
        Button(action: {
            addImageCoordinator = AddImageCoordinator(selectionCount: .one, didAddImageResources: { imageResources in
                titleImage = imageResources.first
                addImageCoordinator = nil
            })
        }, label: {
            IconLabelListCellView(title: "Bild auswählen", image: Image(systemName: "plus"))
        })
    }
}
