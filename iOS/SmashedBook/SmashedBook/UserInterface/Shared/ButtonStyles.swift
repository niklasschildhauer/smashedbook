//
//  Buttons.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 29.09.23.
//

import SwiftUI

struct ScaleAnimationFilledButtonStyle: ButtonStyle {
    @State private var pressing = false
    let backgroundColor: Color
    private let transform = CATransform3DMakeScale(1, 1, 0)
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: LayoutConstants.buttonHeight)
            .frame(minWidth: LayoutConstants.buttonHeight - 2 * LayoutConstants.horizontalSpacing)
            .padding(.horizontal, LayoutConstants.horizontalSpacing)
            .colorIt(for: backgroundColor)
            .buttonBorderShape(.roundedRectangle(radius: LayoutConstants.cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius, style: .continuous))
            .animation(.smooth(duration: 0.1), body: { view in
                // TODO: find another solution -> Maybe use UIKit instead.
//                view.projectionEffect(.init(transform))
                view.scaleEffect(configuration.isPressed ? 0.95 : 1)
            })
    }
}
