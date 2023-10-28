//
//  IconLabelButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 25.09.23.
//

import SwiftUI

struct IconLabelFilledButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticFeedbackInteractor.hapticFeedback(for: .buttonClick)
            action()
        }) {
            HStack(spacing: LayoutConstants.horizontalSpacing) {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "trash.fill")
            }
        }
        .buttonStyle(ScaleAnimationFilledButtonStyle(backgroundColor: .accentColor))
    }
}


#Preview {
    IconLabelFilledButtonView(title: "Test") {
        print("Test")
    }
}

