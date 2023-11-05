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
    // Rename the function to onAdd... instead of didTap...
    var didTapAddAttachment: (() -> Void)? = nil
    
    var body: some View {
        List {
            RecipeEditNameLabelView(name: $recipe.title)
            RecipeEditMetaInformationSectionView(metaInformationModel: $recipe.metaInformation)
//            RecipeEditContentSectionView(title: "Anhänge",
//                                         recipeContent: ,
//                                         addButton:  { addAttachment })
        }
    }
    
    @ViewBuilder var addAttachment: some View {
        if let didTapAddAttachment {
            Button(action: {
                didTapAddAttachment()
            }
                   , label: {
                IconLabelListCellView(title: "Anhang hinzufügen", image: Image(systemName: "plus"))
            })
        }
    }
}

#Preview {
    RecipeEditView(recipe: .constant(recipeModelMock), didTapAddAttachment:  {
        print("Add attachment")
    })
}
