//
//  View.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

struct RecipeEditView: View {
    @Binding var recipe: RecipeModel
    // TODO: Normally I would use a delegate pattern, but is this suitable here? Are there any other ways? As of seperation of concernc i do not want to present an other view within this view.
    // Rename the function to onAdd... instead of didTap...
    var didTapAddAttachment: (() -> Void)
    
    var body: some View {
        List {
            RecipeEditNameLabelView(name: $recipe.title)
            RecipeEditMetaInformationSectionView(metaInformationModel: $recipe.metaInformation)
            RecipeEditAttachmentSectionView(attachments: $recipe.attachments, didTapAddAttachment: didTapAddAttachment)
        }
    }
}

#Preview {
    RecipeEditView(recipe: .constant(recipeModelMock), didTapAddAttachment:  {
        print("Add attachment")
    })
}
