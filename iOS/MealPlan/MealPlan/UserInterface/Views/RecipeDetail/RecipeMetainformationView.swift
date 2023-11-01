//
//  RecipeMetainformationView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeMetainformationView: View {
    let metainformation: RecipeMetainformationModel
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .fill(.thinMaterial)
            HStack(spacing: 0) {
                RecipeMetainformationTileView(emoji: "🔥", value: "\(metainformation.energy?.description ?? "--")")
                Divider()
                RecipeMetainformationTileView(emoji: "⏲️", value: "\(metainformation.duration?.description ?? "--")")
                Divider()
                RecipeMetainformationTileView(emoji: "🍽️", value: "\(metainformation.meal.rawValue)")
            }
        }
    }
}

#Preview {
    RecipeMetainformationView(metainformation: .init(meal: .breakfast, duration: 20))
}
