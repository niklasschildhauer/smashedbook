//
//  EditRecipeAddContentListButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct EditRecipeAddContentButtonListCellView: View {
    var body: some View {
        Menu {
            Button(action: {
                
            }) {
                Label("Foto aufnehmen", systemImage: "camera")
            }
        } label: {
            ButtonListCellView()
        }
    }
}

struct EditRecipeAddContentButtonListCellView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeAddContentButtonListCellView()
    }
}
