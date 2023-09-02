//
//  RecipeListingVIew.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct RecipeListingView: View {
    private var twoColumnGrid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: LayoutConstants.horizontalPadding), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: twoColumnGrid, spacing: LayoutConstants.verticalPadding) {
                ForEach(0..<20) { item in
                    RecipeCardView()
                }
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
        }
    }
}

struct RecipeListingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListingView()
    }
}
