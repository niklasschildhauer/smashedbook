//
//  RecipeEditPortionCounterView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

// TODO Umbauen!
class RecipeEditPortionCounterViewModel: ObservableObject {
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

struct RecipeEditPortionCounterView: View {
    @StateObject var viewModel = RecipeEditPortionCounterViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                IconFilledButtonView(icon: Image(systemName: "minus"), action: viewModel.decreasePotionCount)
                    .uiTestIdentifier("decreasePortionButton")
                    .isHidden($viewModel.hideDecreaseButton)
                Text("\(viewModel.portionCount) \(viewModel.unitText)")
                    .font(.footnote)
                IconFilledButtonView(icon: Image(systemName: "plus"), action: viewModel.increasePotionCount)
                    .uiTestIdentifier("increasePortionButton")
            }
        }
        .uiTestIdentifierForStackWrapper("portionCounter")
    }
}

struct RecipeEditPortionCounterView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditPortionCounterView()
    }
}
