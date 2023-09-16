//
//  EditRecipeDescriptionListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 11.09.23.
//

import SwiftUI

struct EditRecipeDescriptionListCellView: View {
    @State var description: String
    @State private var isEditing = false
    var onEdit: (String) -> Void

    
    var body: some View {
        ListCellWrapperView {
            TextField(description, text: $description, onCommit: {
                onEdit(description)
                isEditing = false
            })
        }
        .deleteSwipeGesture()
        .frame(height: LayoutConstants.listCellHeight)
    }
}

