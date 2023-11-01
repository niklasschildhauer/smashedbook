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
                }, topView: {
                    Text("Lachsrezept")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fontDesign(.monospaced)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                }, bottomView: {
                    RecipeMetainformationView(metainformation: recipe.metaInformation)
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

