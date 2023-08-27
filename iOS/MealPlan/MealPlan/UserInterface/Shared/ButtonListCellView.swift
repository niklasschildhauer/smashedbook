//
//  ButtonListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 22.08.23.
//

import SwiftUI

struct ButtonListCellView: View {
    var body: some View {
        ListCellWrapperView {
            Button {
                print("Aktion wird ausgeführt")
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "pencil")
                    Text("Eine Testbuttonaktion")
                    Spacer()
                }
            }
        }
        .frame(height: LayoutConstants.listCellHeight)
    }
}

struct ButtonListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonListCellView()
    }
}
