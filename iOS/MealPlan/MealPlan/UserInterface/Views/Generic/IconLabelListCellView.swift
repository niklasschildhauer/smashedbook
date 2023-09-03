//
//  ButtonListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 22.08.23.
//

import SwiftUI

struct IconLabelListCellView: View {
    let title: String
    let image: Image
    
    var body: some View {
        ListCellWrapperView {
            HStack {
                Spacer()
                image
                Text(title)
                Spacer()
            }
        }.frame(height: LayoutConstants.listCellHeight)
    }
}

struct IconLabelListCellView_Previews: PreviewProvider {
    static var previews: some View {
        IconLabelListCellView(title: "Testüberschrift", image: Image(systemName: "pencil"))
    }
}
