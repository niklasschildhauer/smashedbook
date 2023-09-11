//
//  EditRecipeDescriptionListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 11.09.23.
//

import SwiftUI

struct EditRecipeDescriptionListCellView: View {
    let description: String
    
    var body: some View {
        ListCellWrapperView {
            Text(description)
        }
        .deleteSwipeGesture()
        .frame(height: LayoutConstants.listCellHeight)
    }
}

