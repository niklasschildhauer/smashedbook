//
//  RecipeEditMetaInformationView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct RecipeEditMetaInformationSectionView: View {
    @Binding var metaInformationModel: RecipeMetaInformationModel
    
    var body: some View {
        ListSectionView(title: "Meta Information") {
            OneLineTitleCustomElementListCellView(title: "Energie") {
                ValueWithUnitInputFieldView(value: $metaInformationModel.energy, unit: "kcl", placeholder: "200")
            }
            OneLineTitleCustomElementListCellView(title: "Mahlzeit") {
                ValuePickerView(values: RecipeMetaInformationModel.Meal.allCases, selectedFlavor: $metaInformationModel.meal)
            }
        }
    }
}

#Preview {
    RecipeEditMetaInformationSectionView(metaInformationModel: .constant(RecipeMetaInformationModel()))
}
