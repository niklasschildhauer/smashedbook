//
//  RecipeDetailTitleView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 23.05.24.
//

import SwiftUI

struct RecipeDetailTitleView: View {
    @Binding var title: String
    @Binding var selectedFont: CustomFont
    
    var body: some View {
        VStack(spacing: LayoutConstants.verticalSpacing) {
            Spacer().frame(height: 40)
            Text(title)
                .font(selectedFont, fontStyle: .largeTitle)
                .foregroundStyle(.white)
            HStack(spacing: LayoutConstants.horizontalSpacing) {
                Text("🔥 320kcal")
                Text("⏲️ 20min")
                Text("🍽️ Abendessen")
            }
            .font(.footnote)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    RecipeDetailTitleView(title: .constant("Testtitel"), selectedFont: .constant(.AbrilFatface))
}
