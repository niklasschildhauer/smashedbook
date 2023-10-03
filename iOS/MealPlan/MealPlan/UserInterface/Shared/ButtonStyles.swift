//
//  Buttons.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 29.09.23.
//

import SwiftUI

struct ScaleAnimationFilledButtonStyle: ButtonStyle {
    let backgroundColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .colorIt(for: backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.bouncy(duration: 0.1), value: configuration.isPressed)
    }
}
