//
//  IconButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

struct IconFilledButtonView: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            icon
                .frame(width: LayoutConstants.buttonHeight, height: LayoutConstants.buttonHeight)
        })
        .buttonStyle(ScaleAnimationFilledButtonStyle(backgroundColor: .accentColor))
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconFilledButtonView(icon: Image(systemName: "plus"), action: {
            print("Test")
        })
    }
}
