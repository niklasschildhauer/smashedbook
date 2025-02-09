//
//  IconLabelButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 25.09.23.
//

import SwiftUI

struct IconLabelFilledButtonView: View {
    let title: String
    let iconSystemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticFeedbackInteractor.hapticFeedback(for: .buttonClick)
            action()
        }) {
            HStack {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer(minLength: LayoutConstants.horizontalSpacing)
                Image(systemName: iconSystemName)
            }
            //.fill(.width, alignment: .center)
        }
        .buttonStyle(ScaleAnimationFilledButtonStyle(backgroundColor: .accentColor))
    }
}


#Preview {
    IconLabelFilledButtonView(title: "Test", iconSystemName: "trash.fill") {
        print("Test")
    }
}

