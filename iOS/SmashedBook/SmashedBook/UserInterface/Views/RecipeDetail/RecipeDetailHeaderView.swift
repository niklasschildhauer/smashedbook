//
//  RecipeDetailHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailHeaderView: View {
    let recipe: RecipeModel
    
    var body: some View {
        Image("ExamplePicture")
            .resizable()
            .scaledToFill()
//        ParallaxHeader(
//            coordinateSpace: identifier,
//            background: {
//                Image("ExamplePicture")
//                    .resizable()
//                    .scaledToFill()
//            }, topView: {
//                RecipeDetailTitleView()
//            }, bottomView: {
//                RecipeDetailMetainformationView(metainformation: recipe.metaInformation)
//            })
    }
}

#Preview {
    RecipeDetailHeaderView(recipe: recipeModelMock)
}
