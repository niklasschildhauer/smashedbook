//
//  RecipeDetailHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

protocol RecipeDetailGeneralInfoDelegate: ObservableObject {
    func addTitleImage()
}

struct RecipeDetailGeneralInfoView<Coordinator>: View where Coordinator: RecipeDetailGeneralInfoDelegate {
    @EnvironmentObject var coordinator:  Coordinator
    @Environment(\.editMode) var editMode
    @Binding var title: String
    @Binding var titleImage: ImageResourceModel?
    
    var isEditModeActive: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        if isEditModeActive {
            VStack {
                Image.createImageFrom(imageResource: $titleImage.wrappedValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
                    .listRowSeparator(.hidden)
                Button("Bearbeiten", action: coordinator.addTitleImage)
                    .buttonStyle(.bordered)
                TextField("Rezeptname", text: $title)
                    .multilineTextAlignment(.center)
                    .font(.GeistMedium, fontStyle: .largeTitle)
                    .listRowSeparator(.hidden)
            }
            .listRowSeparator(.hidden)
        } else {
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
        }
    }
}

#Preview {
    List{
        RecipeDetailGeneralInfoView<RecipeDetailCoordinator>(title: .constant("Lachsrezept"), titleImage: .constant(ImageResourceModel(fileName: "Test")))
    }
    .listStyle(.plain)
}
