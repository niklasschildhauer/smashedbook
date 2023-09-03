//
//  EditRecipePortionCounterView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

class EditRecipePortionCounterViewModel: ObservableObject {
    @Published var portionCount: Int = 2 {
        didSet {
            hideDecreaseButton = portionCount <= 1
        }
    }
    @Published var hideDecreaseButton: Bool = false
    var unitText: String {
        portionCount == 1 ? "Portion" : "Portionen"
    }
    
    
    
    func increasePotionCount() {
        portionCount += 1
    }
    
    func decreasePotionCount() {
        if portionCount > 1 {
            portionCount -= 1
        }
    }
}

struct EditRecipePortionCounterView: View {
    @StateObject var viewModel = EditRecipePortionCounterViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                IconButtonView(icon: Image(systemName: "minus"), action: viewModel.decreasePotionCount)
                    .uiTestIdentifier("decreasePortionButton")
                    .isHidden($viewModel.hideDecreaseButton)
                Text("\(viewModel.portionCount) \(viewModel.unitText)")
                    .font(.footnote)
                IconButtonView(icon: Image(systemName: "plus"), action: viewModel.increasePotionCount)
                    .uiTestIdentifier("increasePortionButton")
            }
        }
        .uiTestIdentifierForStackWrapper("portionCounter")
    }
}

struct EditRecipePortionCounterView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipePortionCounterView()
    }
}
