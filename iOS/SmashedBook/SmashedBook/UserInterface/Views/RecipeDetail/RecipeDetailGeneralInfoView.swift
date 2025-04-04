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
    @Binding var generalInfo: RecipeGeneralInformationModel
    
    var isEditModeActive: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        if isEditModeActive {
            RecipeDetailGeneralInfoEditView(generalInfo: $generalInfo, addTitleImage: coordinator.addTitleImage)
        } else {
            ParallaxHeader() {
                Image.createImageFrom(imageResource: $generalInfo.titleImage.wrappedValue)
                    .resizable()
                    .scaledToFill()
            } bottomView: {
                RecipeDetailTitleView(generalInformation: $generalInfo)
            }
        }
    }
}
