//
//  RecipeDetailAttachmentView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailAttachmentImageView: View {
    var body: some View {
        Image("ExamplePicture")
            .resizable()
            .scaledToFill()
    }
}

#Preview {
    RecipeDetailAttachmentImageView()
        .frame(width: 80, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
}
