//
//  HapticFeedbackInteractor.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 29.09.23.
//

import SwiftUI

enum HapticFeedbackEvents  {
    case buttonClick
}

struct HapticFeedbackInteractor {
    static func hapticFeedback(for event: HapticFeedbackEvents) {
        switch event{
        case .buttonClick: executeHapticFeedback(for: .soft)
        }
    }
    
    private static func executeHapticFeedback(for impactStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactMed = UIImpactFeedbackGenerator(style: impactStyle)
        impactMed.impactOccurred()
    }
}
