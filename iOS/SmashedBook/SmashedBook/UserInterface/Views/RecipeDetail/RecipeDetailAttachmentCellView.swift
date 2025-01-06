//
//  RecipeDetailAttachmentView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentCellView: View {
    private static let attachmentHeight = 220.0
    private static let attachmentWidth = 125.0
    
    @Binding var attachment: ImageResourceModel
    
    private let dataSource: ResourcesDataSourceProtocol = ResourcesDataSource.getInstance()
    
    var body: some View {
        Image.createImageFrom(imageResource: attachment)
            .resizable()
            .scaledToFill()
            .frame(width: RecipeDetailAttachmentCellView.attachmentWidth, height: RecipeDetailAttachmentCellView.attachmentHeight)
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
    }
}

#Preview {
    RecipeDetailAttachmentCellView(attachment: .constant(ImageResourceModel(fileName: "test")))
        .frame(width: 80, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
}
