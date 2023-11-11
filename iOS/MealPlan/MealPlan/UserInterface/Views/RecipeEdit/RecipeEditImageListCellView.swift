//
//  EditImageListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct RecipeEditAttachmentPreviewListCellView: View {
    let attachmentPreviewImage: Image
    
    var body: some View {
        ListCellWrapperView {
            attachmentPreviewImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
        }
        .deleteSwipeGesture()
        .frame(height: 100)
    }
}

//https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers

#Preview {
    RecipeEditAttachmentPreviewListCellView(attachmentPreviewImage: Image("ExampleRecipe"))
}
