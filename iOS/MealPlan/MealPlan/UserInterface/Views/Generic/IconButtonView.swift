//
//  IconButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI

struct IconButtonView: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            icon
                .frame(width: LayoutConstants.buttonHeight, height: LayoutConstants.buttonHeight)
        })
    }
}

#Preview {
    IconButtonView(icon: Image(systemName: "plus"), action: {
        print("Test")
    })
}
