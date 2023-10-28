//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    
    var body: some View {
        ScrollView {
            ParallaxHeader(
                coordinateSpace: identifier,
                background: {
                Image("ExamplePicture")
                    .resizable()
                    .scaledToFill()
            }, metaInfo: {
                HStack(spacing: 0) {
                    RecipeMetaInformationView(emoji: "🔥", value: "\(recipe.metaInformation.energy?.description ?? "--")")
                    Divider()
                    RecipeMetaInformationView(emoji: "⏲️", value: "\(recipe.metaInformation.duration?.description ?? "--")")
                    Divider()
                    RecipeMetaInformationView(emoji: "🍽️", value: "\(recipe.metaInformation.meal.rawValue)")
                }
            })
            ZStack {
                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                    .foregroundColor(.white)
                
                VStack {
                    ForEach(0..<20) { _ in
                        OneLineTitleCustomElementListCellView(title: "Titel") {
                            Text("Das ist ein Test")
                        }
                        .frame(height: LayoutConstants.listCellHeight)
                        Divider()
                    }
                }
                .padding(LayoutConstants.safeAreaSpacing)
            }
        }
        .navigationBarBackButtonHidden(true)
        .coordinateSpace(name: identifier)
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}

