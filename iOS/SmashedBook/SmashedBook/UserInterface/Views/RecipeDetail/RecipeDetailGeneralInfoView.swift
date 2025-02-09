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
    
    @State var selectedFont: CustomFont = .AbrilFatface
    
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
                    .font($selectedFont.wrappedValue, fontStyle: .largeTitle)
                    .listRowSeparator(.hidden)
                    .frame(height: 75)
                
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    ForEach(CustomFont.allCases, id: \.self) { font in
                        Button {
                            selectedFont = font
                        } label: {
                            ZStack(alignment: .center) {
                                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                    .stroke(.blue, lineWidth: 3)
                                    .frame(width: 40)
                                    .isHidden {
                                        font != selectedFont
                                    }
                                Text("Ab")
                                    .font(font, fontStyle: .title)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .selectionDisabled()
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
    RecipeDetailGeneralInfoView<RecipeDetailCoordinator>(title: .constant("Lachsrezept"), titleImage: .constant(ImageResourceModel(fileName: "Test")))
}
