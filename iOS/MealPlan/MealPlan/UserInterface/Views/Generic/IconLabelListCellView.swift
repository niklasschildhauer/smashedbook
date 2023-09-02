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
        HStack {
            Spacer()
            image
            Text(title)
            Spacer()
        }
    }
}

struct ButtonListCellView_Previews: PreviewProvider {
    static var previews: some View {
        IconLabelView(title: "Testüberschrift")
    }
}
