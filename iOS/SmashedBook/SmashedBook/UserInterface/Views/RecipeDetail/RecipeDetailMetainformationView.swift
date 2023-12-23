//
//  RecipeMetainformationView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailMetainformationView: View {
    let metainformation: RecipeMetainformationModel
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(.thinMaterial)
            HStack(spacing: 0) {
                RecipeDetailMetainformationTileView(emoji: "🔥", value: "\(metainformation.energy ?? "--")")
                Divider()
                RecipeDetailMetainformationTileView(emoji: "⏲️", value: "\(metainformation.duration?.description ?? "--")")
                Divider()
                RecipeDetailMetainformationTileView(emoji: "🍽️", value: "\(metainformation.meal.rawValue)")
            }
        }
    }
}

#Preview {
    RecipeDetailMetainformationView(metainformation: .init(meal: .breakfast, duration: 20))
}
