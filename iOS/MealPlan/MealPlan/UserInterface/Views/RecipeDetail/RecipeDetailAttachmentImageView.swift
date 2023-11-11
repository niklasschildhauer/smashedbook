//
//  RecipeDetailAttachmentView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentImageView: View {
    @Binding var attachment: RecipeAttachmentModel
    
    // TODO: remove it?
    private let test = FileSystemAttachmentDataSource()
    
    var body: some View {
        if let imageData = test.load(attachment: attachment),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Text("Not loadable")
        }
    }
}

#Preview {
    RecipeDetailAttachmentImageView(attachment: .constant(RecipeAttachmentModel(fileName: "test")))
        .frame(width: 80, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
}
