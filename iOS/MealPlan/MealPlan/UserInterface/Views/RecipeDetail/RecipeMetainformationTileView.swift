//
//  RecipeMetaInfoView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 28.10.23.
//

import SwiftUI

struct RecipeMetainformationTileView: View {
    let emoji: String
    let value: String
    
    var body: some View {
        VStack {
            Text(emoji)
                .font(.title)
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RecipeMetainformationTileView(emoji: "🔥", value: "800 kcl")
        .background(.black)
}
