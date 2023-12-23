//
//  RecipeDetailTitleView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailTitleView: View {
    var body: some View {
        Text("Lachsrezept")
            .font(.largeTitle)
            .fontWeight(.black)
            .fontDesign(.monospaced)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.white)
    }
}

#Preview {
    RecipeDetailTitleView()
}
