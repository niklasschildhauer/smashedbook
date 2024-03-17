//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Binding var recipe: RecipeModel
    @State var open = false
    
    var didTapShowAttachment: ((RecipeAttachmentModel) -> Void)? = nil
    
    var body: some View {
        List {
//            Image("ExamplePicture")
//                .resizable()
//                .scaledToFill()
//                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

            ParallaxHeader() {
                Image("ExamplePicture")
                    .resizable()
                    .scaledToFill()
            } bottomView: {
                VStack(spacing: LayoutConstants.verticalSpacing) {
                    Spacer().frame(height: 50)
                    Text(recipe.title)
                        .font(.AbrilFatface, fontStyle: .largeTitle)
                        .foregroundStyle(.white)
                    HStack(spacing: LayoutConstants.horizontalSpacing) {
                        Text("🔥 320kcal")
                        Text("⏲️ 20min")
                        Text("🍽️ Abendessen")
                    }
                    .font(.footnote)
                    .foregroundStyle(.white)
                }
                .fill(.width, alignment: .bottom)
                .padding(.bottom, LayoutConstants.safeAreaSpacing)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                )
            }
            .listRowSeparator(.hidden)
    
            Button("Test") {
                open.toggle()
            }
            RecipeDetailIngredientsView(ingredients: $recipe.ingredients)
            RecipeDetailStepsView(steps: $recipe.steps)
            RecipeDetailAttachmentsView(attachments: $recipe.attachments) { attachment in
                didTapShowAttachment?(attachment)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .listStyle(.plain)
        .coordinateSpace(.named("stack"))
        .sheet(isPresented: $open, content: {
            Text("Test")
        })
    }
}

#Preview {
    RecipeDetailContentView(recipe: .constant(recipeModelMock))
}

