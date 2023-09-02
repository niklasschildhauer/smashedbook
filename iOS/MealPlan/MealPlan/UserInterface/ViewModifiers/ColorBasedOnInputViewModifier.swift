//
//  ColorBasedOnInputViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct ColorBasedOnInputViewModifier: ViewModifier {
    let input: String
    
    @State private var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(ColorBasedOnInputGenerator.generateForegroundColorBasedOnInput(input: input))
            .background(ColorBasedOnInputGenerator.generateBackgroundColorBasedOnInput(input: input))
    }
}

extension View {
    func colorIt(for input: String) -> some View {
        self.modifier(ColorBasedOnInputViewModifier(input: input))
    }
}
