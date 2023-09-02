//
//  EditRecipeMetaInformationView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

enum TestEnum: String, PickerValue {
    case breakfast = "Frühstück"
    case lunch = "Mittagessen"
    case dinner = "Abendessen"
    
    var id: String { self.rawValue }
}

struct EditRecipeMetaInformationSectionView: View {
    @State var energyTest = ""
    @State var selectedMeal = TestEnum.breakfast
    
    var body: some View {
        ListSectionView(title: "Meta Information") {
            OneLineTitleCustomElementListCellView(title: "Energie") {
                ValueWithUnitInputFieldView(value: $energyTest, unit: "kcl", placeholder: "200")
            }
            .uiTestIdentifierForStackWrapper("energyInput")
            Divider()
            OneLineTitleCustomElementListCellView(title: "Mahlzeit") {
                ValuePickerView(values: TestEnum.allCases, selectedFlavor: $selectedMeal)
            }
            .uiTestIdentifierForStackWrapper("mealInput")
        }
    }
}

struct EditRecipeMetaInformationView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeMetaInformationSectionView()
    }
}
