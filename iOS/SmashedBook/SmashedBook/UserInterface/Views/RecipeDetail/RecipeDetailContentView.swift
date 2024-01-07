//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Binding var recipe: RecipeModel
    
    var body: some View {
        List {
            ParallaxHeader() {
                Image("ExamplePicture")
                    .resizable()
                    .scaledToFill()
            } bottomView: {
                Text("Test")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
            
            VStack (spacing: LayoutConstants.verticalSpacing) {
                RecipeDetailMetainformationView(metainformation: recipe.metaInformation)
                //                    .padding(.vertical ,LayoutConstants.verticalSpacing)
                //                    .padding(.horizontal ,LayoutConstants.horizontalSpacing)
                
                
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: LayoutConstants.verticalSpacing, leading: LayoutConstants.safeAreaSpacing, bottom: LayoutConstants.verticalSpacing, trailing: LayoutConstants.safeAreaSpacing))
            ForEach(0..<5) { _ in
                Text("Das ist ein Test")
                    .listRowInsets(.init(top: LayoutConstants.verticalSpacing, leading: LayoutConstants.safeAreaSpacing, bottom: LayoutConstants.verticalSpacing, trailing: LayoutConstants.safeAreaSpacing))
            }
        }
        .edgesIgnoringSafeArea(.top)
        .listStyle(.plain)
      
    }
}

#Preview {
    RecipeDetailContentView(recipe: .constant(recipeModelMock))
}

