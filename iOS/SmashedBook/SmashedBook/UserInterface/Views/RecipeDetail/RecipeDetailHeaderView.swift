//
//  RecipeDetailHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct RecipeDetailHeaderView<Coordinator>: View where Coordinator: RecipeDetailCoordinating {
    @EnvironmentObject var coordinator:  Coordinator
    @Binding var title: String
    @Binding var titleImage: ImageResourceModel?
    @Environment(\.editMode) var editMode
    
    var isEditedModeActive: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        ParallaxHeader() {
            Image.createImageFrom(imageResource: $titleImage.wrappedValue)
                .resizable()
                .scaledToFill()
        } bottomView: {
            RecipeDetailTitleView(title: title)
            .fill(.width, alignment: .bottom)
            .padding(.bottom, LayoutConstants.safeAreaSpacing)
            .background(
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
            )
        }
        .listRowSeparator(.hidden)
        .overlay {
            if isEditedModeActive {
                Button("Edit") {
                    coordinator.addTitleImage()
                }
            }
        }
    }
}

#Preview {
    List{
        RecipeDetailHeaderView<RecipeDetailCoordinator>(title: .constant("Lachsrezept"), titleImage: .constant(ImageResourceModel(fileName: "Test")))
    }
}
