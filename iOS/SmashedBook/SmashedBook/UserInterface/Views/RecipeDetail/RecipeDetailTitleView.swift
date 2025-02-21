//
//  RecipeDetailTitleView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 23.05.24.
//

import SwiftUI

struct RecipeDetailTitleView: View {
    @Binding var generalInformation: RecipeGeneralInformationModel
    
    var body: some View {
        VStack(spacing: LayoutConstants.verticalSpacing) {
            Spacer().frame(height: 40)
            Text(generalInformation.title)
                .font(generalInformation.font, fontStyle: .largeTitle)
                .foregroundStyle(.white)
            if generalInformation.energy != nil || generalInformation.duration != nil || generalInformation.meal != nil {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    if let energy = generalInformation.energy {
                        Text("🔥 \(energy)kcal")
                    }
                    if let duration = generalInformation.duration {
                        Text("⏲️ \(String(describing: duration))min")
                    }
                    if let meal = generalInformation.meal?.rawValue {
                        Text("🍽️ \(meal)")
                    }
                }
                .font(.footnote)
                .foregroundStyle(.white)
            }
        }
    }
}

