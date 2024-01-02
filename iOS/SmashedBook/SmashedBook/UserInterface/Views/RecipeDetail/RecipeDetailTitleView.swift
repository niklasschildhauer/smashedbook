//
//  RecipeDetailTitleView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailTitleView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Lachsrezept")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.clear,
                                                           Color(red: 0, green: 0, blue: 0, opacity: 0.3),
                                                           Color(red: 0, green: 0, blue: 0, opacity: 0.6)
                                                          ]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
        .background(.clear)
    }
}

#Preview {
    ZStack {
        Image("ExampleRecipe")
            .frame(height: 400)
        RecipeDetailTitleView()
    }
}
