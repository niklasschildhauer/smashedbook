//
//  HideViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

struct HideViewModifier: ViewModifier {
    @Binding var isHidden: Bool
    
    func body(content: Content) -> some View {
        if $isHidden.wrappedValue {
            content.hidden()
        } else {
            content
        }
    }
}

struct HideViewModifier2: ViewModifier {
    var isHidden: () -> Bool
    
    func body(content: Content) -> some View {
        if isHidden() {
            content.hidden()
        } else {
            content
        }
    }
}

extension View {
    func isHidden(_ hidden: Binding<Bool>) -> some View {
        self.modifier(HideViewModifier(isHidden: hidden))
    }
    
    func isHidden(_ hideFunction: @escaping () -> Bool) -> some View {
        self.modifier(HideViewModifier2(isHidden: hideFunction))
    }
}
