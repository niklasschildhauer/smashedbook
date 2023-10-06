//
//  View.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

protocol RecipeEditViewDelegate {
    func didTapAddIngredient(in view: RecipeEditView)
    func didTapAddStep(in view: RecipeEditView)
}

struct RecipeEditView: View {
    @Binding var recipe: RecipeModel
    // TODO: Normally I would use a delegate pattern, but is this suitable here? Are there any other ways? As of seperation of concernc i do not want to present an other view within this view.
    var didTapAddIngredient: (() -> Void)? = nil
    var didTapAddStep: (() -> Void)? = nil
    
    var body: some View {
        List {
            RecipeEditNameLabelView(name: $recipe.title)
            RecipeEditMetaInformationSectionView(metaInformationModel: $recipe.metaInformation)
            RecipeEditContentSectionView(title: "Zutaten",
                                         recipeContent: $recipe.ingredients,
                                         trailingAction: { RecipeEditPortionCounterView() },
                                         addButton:  { addIngredientButton })
            RecipeEditContentSectionView(title: "Anleitung",
                                         recipeContent: $recipe.steps,
                                         addButton:  { addStepButton })
        }
    }
    
    @ViewBuilder var addIngredientButton: some View {
        if let didTapAddIngredient {
            Button(action: {
                didTapAddIngredient()
            }
                   , label: {
                IconLabelListCellView(title: "Zutat hinzufügen", image: Image(systemName: "plus"))
                    .background(.white)
            })
        }
    }
    
    @ViewBuilder var addStepButton: some View {
        if let didTapAddStep {
            Button(action: {
                didTapAddStep()
            }
                   , label: {
                IconLabelListCellView(title: "Schritt hinzufügen", image: Image(systemName: "plus"))
                    .background(.white)
            })
        }
    }
}

#Preview {
    RecipeEditView(recipe: .constant(recipeModelMock), didTapAddIngredient:  {
        print("Add step")
    }, didTapAddStep: {
        print("Add ingredient")
    })
}
