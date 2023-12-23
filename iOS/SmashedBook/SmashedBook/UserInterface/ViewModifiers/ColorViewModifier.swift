//
//  ColorBasedOnInputViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct ColorBasedOnInputViewModifier: ViewModifier {
    let input: String
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(ColorBasedOnInputGenerator.generateForegroundColorBasedOnInput(input: input))
            .background(ColorBasedOnInputGenerator.generateBackgroundColorBasedOnInput(input: input))
    }
}

struct BackgroundColorViewModifier: ViewModifier {
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(ForegroundColorGenerator.generateForegroundColor(for: background))
            .background(background)
    }
}

extension View {
    func colorIt(for input: String) -> some View {
        self.modifier(ColorBasedOnInputViewModifier(input: input))
    }
    
    func colorIt(for background: Color) -> some View {
        self.modifier(BackgroundColorViewModifier(background: background))
    }
}
