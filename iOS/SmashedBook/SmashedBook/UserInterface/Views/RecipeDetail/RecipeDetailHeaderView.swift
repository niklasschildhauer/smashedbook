//
//  RecipeDetailHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailHeaderView: View {
    @Binding var title: String
    
    var body: some View {
        ParallaxHeader() {
            Image("ExamplePicture")
                .resizable()
                .scaledToFill()
        } bottomView: {
            RecipeDetailTitleView(title: title)
            .fill(.width, alignment: .bottom)
            .padding(.bottom, LayoutConstants.safeAreaSpacing)
            .background(
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
            )
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    List{
        RecipeDetailHeaderView(title: .constant("Lachsrezept"))
    }
}
